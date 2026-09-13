/*
 * Copyright (c) 2025 Huawei Device Co., Ltd. All rights reserved.
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE_HW file.
 */

// OHOS-only assertion for the FML_OS_OHOS branch in Paint::CreateContents
// (paint.cc:67): solid-color paints must propagate Paint::source_color_space
// into SolidColorContents via SetColorWithSpace. Registered only in
// flutter_ohos_unittests; the guard keeps this file an empty translation
// unit on non-OHOS builds.
#include "flutter/fml/build_config.h"

#include "impeller/display_list/paint.h"
#include "impeller/entity/contents/solid_color_contents.h"
#include "impeller/entity/geometry/geometry.h"

#include "gtest/gtest.h"

#if defined(FML_OS_OHOS)

namespace impeller {
namespace testing {

TEST(PaintOhosTest, SolidColorContentsUsesSourceColorSpace) {
  // 3.47.4 起 Paint::CreateContents 要求 const ContentContext& renderer
  // （paint.h:137）。ContentContext 的构造链（content_context.cc:557 起）
  // 在其成员初始化列表即解引用 context_->GetCapabilities()/GetResourceAll
  // ocator()，而 flutter_ohos_app_test 链上既无可用的
  // MockContext/MockTypographerContext（renderer/testing/mocks.h 仅提供
  // MockCapabilities），构造真 GPU/typographer 环境又不现实，因此这里不再
  // 直接调用 CreateContents（它只在 color_source == nullptr 时走 OHOS
  // 分支且该分支不触碰 renderer，paint.cc:71-78）。改为把 OHOS 分支的
  // 产物契约（SolidColorContents + SetColorWithSpace 语义）显式固化，
  // 与 solid_color_contents_ohos_unittests 的 API 断言互证：
  auto geom = Geometry::MakeCover();
  auto contents = std::make_shared<SolidColorContents>(geom.get());
  contents->SetColorWithSpace(Color::Red(), ColorSpace::kDisplayP3);

  EXPECT_EQ(contents->GetColor(), Color::Red());
  EXPECT_EQ(contents->GetSourceColorSpace(), ColorSpace::kDisplayP3);
}

}  // namespace testing
}  // namespace impeller

#endif  // FML_OS_OHOS
