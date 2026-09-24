/*
 * Copyright 2026 Huawei Device Co., Ltd. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE_HW file.
 */

#include "flutter/fml/build_config.h"

#include "gtest/gtest.h"
#include "impeller/typographer/backends/skia/typographer_context_skia.h"

#if defined(FML_OS_OHOS)

namespace impeller {
namespace testing {

TEST(TypographerContextSkiaOhosTest, MakeReturnsValid) {
  auto context = TypographerContextSkia::Make();
  EXPECT_NE(context, nullptr);
}

TEST(TypographerContextSkiaOhosTest, MakeIsConsistent) {
  auto context1 = TypographerContextSkia::Make();
  auto context2 = TypographerContextSkia::Make();
  EXPECT_NE(context1, nullptr);
  EXPECT_NE(context2, nullptr);
}

}  // namespace testing
}  // namespace impeller

#endif  // defined(FML_OS_OHOS)
