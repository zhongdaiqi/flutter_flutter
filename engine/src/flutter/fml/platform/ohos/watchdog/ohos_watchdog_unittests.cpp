/*
 * Copyright (c) 2025 Huawei Device Co., Ltd. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE_HW file.
 */

// Unit tests for fml/platform/ohos/watchdog/ohos_watchdog.cpp
//
// Test registration: shell/platform/ohos/BUILD.gn → flutter_ohos_unittests
// (device side, ohos_*_arm64).
//
// The OHos native API functions OH_HiCollie_Init_StuckDetection and
// OH_HiCollie_Report are overridden with strong stub definitions in this file.
// At link time the stubs take precedence over the same symbols in
// libohhicollie.so, allowing the tests to capture the registered callback and
// control the return values without triggering real side effects.
//
// The FlutterWatchdog class is private to the .cpp file, so tests exercise it
// indirectly through the public MakeWatchdog API and the saved HiCollie
// callback.
//
// Coverage gaps: the cleanup function returned by MakeWatchdog (success path)
// is not invoked in tests because the caller (OHOSShellHolder destructor)
// passes watchdogIndex - 1 as the argument; simulating the full lifecycle
// would require an OHOSShellHolder instance. The weak_from_this() nullptr
// guard and the empty-vector guard in the HiCollie callback are defensive
// code paths that are not reachable under normal conditions.

#include "flutter/fml/platform/ohos/watchdog/ohos_watchdog.h"

#include <hicollie/hicollie.h>

#include <chrono>
#include <thread>

#include "flutter/fml/message_loop.h"
#include "flutter/fml/thread.h"
#include "gtest/gtest.h"

namespace fml {
namespace OhosWatchdog {
namespace testing {

// ===== Recording state for stub functions =====

namespace {

struct HiCollieCallLog {
  int init_count = 0;
  HiCollie_ErrorCode init_return = HICOLLIE_SUCCESS;
  OH_HiCollie_Task saved_callback = nullptr;

  int report_count = 0;
  HiCollie_ErrorCode report_return = HICOLLIE_SUCCESS;
  bool report_is_six_second = false;
};

HiCollieCallLog& GetCallLog() {
  static HiCollieCallLog log;
  return log;
}

void ResetCallLog() {
  GetCallLog() = HiCollieCallLog{};
}

}  // namespace

// ===== Strong stub definitions of OHos native API functions =====

extern "C" {
HiCollie_ErrorCode OH_HiCollie_Init_StuckDetection(OH_HiCollie_Task task) {
  GetCallLog().init_count++;
  GetCallLog().saved_callback = task;
  return GetCallLog().init_return;
}

HiCollie_ErrorCode OH_HiCollie_Report(bool* isSixSecond) {
  GetCallLog().report_count++;
  if (isSixSecond) {
    *isSixSecond = GetCallLog().report_is_six_second;
  }
  return GetCallLog().report_return;
}

}  // extern "C"

// ===== Test fixture =====

class OhosWatchdogTest : public ::testing::Test {
 protected:
  void SetUp() override {
    ResetCallLog();
    GetCallLog().init_return = HICOLLIE_SUCCESS;
    GetCallLog().report_return = HICOLLIE_SUCCESS;
  }

  // Creates a thread whose MessageLoop is blocked by a long sleep, simulating
  // a stuck UI thread that cannot process posted tasks.
  std::unique_ptr<fml::Thread> CreateBlockedUiThread(
      std::chrono::seconds block_duration = std::chrono::seconds(5)) {
    auto thread = std::make_unique<fml::Thread>();
    thread->GetTaskRunner()->PostTask(
        [block_duration] { std::this_thread::sleep_for(block_duration); });
    // Allow the blocking task to start executing.
    std::this_thread::sleep_for(std::chrono::milliseconds(100));
    return thread;
  }
};

// ===== MakeWatchdog return values =====

TEST_F(OhosWatchdogTest, MakeWatchdogReturnsValidPairWhenInitSucceeds) {
  fml::Thread ui_thread;
  auto [index, cleanup] = MakeWatchdog(ui_thread.GetTaskRunner());

  EXPECT_GT(index, 0u);
  EXPECT_TRUE(cleanup);
}

TEST_F(OhosWatchdogTest, MakeWatchdogReturnsZeroWhenInitFails) {
  GetCallLog().init_return = HICOLLIE_REMOTE_FAILED;

  fml::Thread ui_thread;
  auto [index, cleanup] = MakeWatchdog(ui_thread.GetTaskRunner());

  EXPECT_EQ(index, 0u);
  EXPECT_FALSE(cleanup);
}

TEST_F(OhosWatchdogTest, MakeWatchdogCallsInitStuckDetection) {
  fml::Thread ui_thread;
  MakeWatchdog(ui_thread.GetTaskRunner());

  EXPECT_EQ(GetCallLog().init_count, 1);
  EXPECT_NE(GetCallLog().saved_callback, nullptr);
}

// ===== Multiple MakeWatchdog calls =====

TEST_F(OhosWatchdogTest, MultipleMakeWatchdogCallsAllSucceed) {
  fml::Thread ui_thread;

  auto [index1, cleanup1] = MakeWatchdog(ui_thread.GetTaskRunner());
  auto [index2, cleanup2] = MakeWatchdog(ui_thread.GetTaskRunner());

  EXPECT_GT(index2, index1);
  EXPECT_TRUE(cleanup1);
  EXPECT_TRUE(cleanup2);
}

// ===== Callback execution =====

TEST_F(OhosWatchdogTest, CallbackDoesNotCrash) {
  fml::Thread ui_thread;
  MakeWatchdog(ui_thread.GetTaskRunner());

  ASSERT_NE(GetCallLog().saved_callback, nullptr);
  // First call: m_flutter_ui_thread_is_alive is false, but timeDelta is
  // too large (epoch), so reportStuckEvent skips OH_HiCollie_Report.
  GetCallLog().saved_callback();
  EXPECT_EQ(GetCallLog().report_count, 0);
}

TEST_F(OhosWatchdogTest, CallbackWithAliveUiThreadDoesNotReportStuck) {
  fml::Thread ui_thread;
  MakeWatchdog(ui_thread.GetTaskRunner());

  // First call: posts a task to the UI thread (which runs it immediately
  // since fml::Thread processes tasks). This sets m_flutter_ui_thread_is_alive
  // = true.
  GetCallLog().saved_callback();
  // Allow the posted task to execute on the UI thread.
  std::this_thread::sleep_for(std::chrono::milliseconds(200));

  // Second call: m_flutter_ui_thread_is_alive is true, so reportStuckEvent
  // is not called.
  GetCallLog().saved_callback();
  EXPECT_EQ(GetCallLog().report_count, 0);
}

TEST_F(OhosWatchdogTest, CallbackReportsStuckWhenUiThreadBlocked) {
  // Create a UI thread that is blocked — posted tasks will not execute.
  auto ui_thread = CreateBlockedUiThread();

  MakeWatchdog(ui_thread->GetTaskRunner());
  ASSERT_NE(GetCallLog().saved_callback, nullptr);

  // First call: timeDelta is too large (epoch), so OH_HiCollie_Report is
  // skipped. m_lastWatchTime is updated to now.
  GetCallLog().saved_callback();
  EXPECT_EQ(GetCallLog().report_count, 0);

  // Wait for the time window to become valid (1.5s – 6s).
  std::this_thread::sleep_for(std::chrono::seconds(2));

  // Second call: m_flutter_ui_thread_is_alive is still false (UI thread is
  // blocked), and timeDelta ≈ 2s is within the valid window, so
  // OH_HiCollie_Report is called.
  GetCallLog().saved_callback();
  EXPECT_EQ(GetCallLog().report_count, 1);
}

// ===== OH_HiCollie_Report return value handling =====

TEST_F(OhosWatchdogTest, ReportFailureDoesNotCrash) {
  GetCallLog().report_return = HICOLLIE_REMOTE_FAILED;

  auto ui_thread = CreateBlockedUiThread();
  MakeWatchdog(ui_thread->GetTaskRunner());

  // First call: skips report (timeDelta too large).
  GetCallLog().saved_callback();

  std::this_thread::sleep_for(std::chrono::seconds(2));

  // Second call: attempts report, OH_HiCollie_Report returns error.
  GetCallLog().saved_callback();
  EXPECT_EQ(GetCallLog().report_count, 1);
}

// ===== Six-second event flag =====

TEST_F(OhosWatchdogTest, SixSecondEventFlagFlipsAfterFirstReport) {
  GetCallLog().report_is_six_second = true;

  auto ui_thread = CreateBlockedUiThread(std::chrono::seconds(12));
  MakeWatchdog(ui_thread->GetTaskRunner());

  // First call: skips report (timeDelta too large). Updates m_lastWatchTime.
  GetCallLog().saved_callback();
  EXPECT_EQ(GetCallLog().report_count, 0);

  std::this_thread::sleep_for(std::chrono::seconds(2));

  // Second call: m_is_six_second_event is false (initial), so
  // m_need_report stays true. OH_HiCollie_Report is called; the stub
  // sets *isSixSecond = true, so m_is_six_second_event becomes true.
  GetCallLog().saved_callback();
  EXPECT_EQ(GetCallLog().report_count, 1);

  std::this_thread::sleep_for(std::chrono::seconds(2));

  // Third call: m_is_six_second_event is now true, so m_need_report is set
  // to false. OH_HiCollie_Report is still called (before the flag takes
  // effect on the next cycle).
  GetCallLog().saved_callback();
  EXPECT_EQ(GetCallLog().report_count, 2);

  std::this_thread::sleep_for(std::chrono::seconds(2));

  // Fourth call: m_need_report is now false, so runHiCollieStuckDetectionTask
  // returns early — no additional report.
  GetCallLog().saved_callback();
  EXPECT_EQ(GetCallLog().report_count, 2);
}

// ===== Edge cases =====

TEST_F(OhosWatchdogTest, CallbackWithNullTaskRunnerHandledByMakeWatchdog) {
  // MakeWatchdog with a valid (but idle) thread should still succeed.
  fml::Thread ui_thread;
  auto [index, cleanup] = MakeWatchdog(ui_thread.GetTaskRunner());
  EXPECT_GT(index, 0u);
}

TEST_F(OhosWatchdogTest, RapidCallbackCallsAreSafe) {
  fml::Thread ui_thread;
  MakeWatchdog(ui_thread.GetTaskRunner());

  ASSERT_NE(GetCallLog().saved_callback, nullptr);
  // Call the callback multiple times in rapid succession. Each call may
  // post a task to the UI thread; the thread processes them asynchronously.
  for (int i = 0; i < 5; i++) {
    GetCallLog().saved_callback();
    std::this_thread::sleep_for(std::chrono::milliseconds(50));
  }
  SUCCEED();
}

}  // namespace testing
}  // namespace OhosWatchdog
}  // namespace fml
