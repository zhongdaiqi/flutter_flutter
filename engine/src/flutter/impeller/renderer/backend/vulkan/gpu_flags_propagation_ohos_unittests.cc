/*
 * Copyright 2026 Huawei Device Co., Ltd. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE_HW file.
 */

#include "flutter/fml/build_config.h"

#if defined(FML_OS_OHOS)

#include "gtest/gtest.h"
#include "impeller/renderer/backend/vulkan/test/mock_vulkan.h"
#include "impeller/typographer/backends/skia/typographer_context_skia.h"

namespace impeller {
namespace testing {

TEST(GPUFlagsPropagationOhosTest, TypographerContextCreated) {
  auto typographer = TypographerContextSkia::Make();
  EXPECT_NE(typographer, nullptr);
}

TEST(GPUFlagsPropagationOhosTest, MockContextAndTypographerCoexist) {
  auto const vk_context = MockVulkanContextBuilder().Build();
  ASSERT_NE(vk_context, nullptr);

  auto typographer = TypographerContextSkia::Make();
  ASSERT_NE(typographer, nullptr);

  EXPECT_NE(vk_context, nullptr);
  EXPECT_NE(typographer, nullptr);
}

}  // namespace testing
}  // namespace impeller

#endif  // defined(FML_OS_OHOS)
