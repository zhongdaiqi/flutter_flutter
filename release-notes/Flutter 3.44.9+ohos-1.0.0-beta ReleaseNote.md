# Flutter 3.44.9+ohos-1.0.0-beta Release Notes

> **版本状态**：beta<br/>
> **发布日期**：2026-10-24<br/>
> **Flutter 上游社区基线版本**：[![Flutter Version](https://img-transfer.gitcode.com?p=https%3A%2F%2Fimg.shields.io%2Fbadge%2FFlutter-3.44.9-blue.svg%3Flogo%3Dflutter&projectId=CPF-Flutter&pageUrl=https%3A%2F%2Fgitcode.com%2FCPF-Flutter)](https://github.com/flutter/flutter/commit/6b182d2c7585eba26d4edce0f97630effd256c33)

---

## 版本概述

本版本为 Flutter OpenHarmony 平台 1.0.0-beta 版本，基于 Flutter 3.44.9 版本适配。本版本采用 +ohos build metadata 版本格式（与上游稳定版等价优先级），并持续完善 OpenHarmony 平台侧能力，提供平台化 Channel、外接纹理、云端 SDK 等特性，修复多项缺陷。

## 版本配套

| 配套 | 版本 | 说明 |
| --- | --- | --- |
| Flutter SDK | [3.44.9+ohos-1.0.0-beta](https://gitcode.com/CPF-Flutter/flutter_flutter/tree/3.44.9+ohos-1.0.0-beta) | 版本号采用 `+ohos` build metadata 格式 |
| DevEco Studio | DevEco Studio 26.0.0 Release | 开发工具（IDE），[前往下载](https://developer.huawei.com/consumer/cn/download/deveco-studio) |
| Command Line Tools | Command Line Tools 26.0.0 Release | 开发工具集，[前往下载](https://developer.huawei.com/consumer/cn/download/command-line-tools-for-hmos) |
| 引擎构建最低 SDK | 26.0.0 | 配置 `DEVECO_SDK_HOME` 环境变量指向 SDK 路径 |
| 应用编译最低 SDK | 26.0.0 | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compileSdkVersion": "26.0.0" |
| 应用运行最低 SDK | 5.0.5(17) | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compatibleSdkVersion": "5.0.5(17)" |

## 主要变更

### 新增

- feat: add --use-ccache option to ohos.py to enable ccache engine builds
- feat(HCPP): adopt overlay-only a11y registration and inject wrapper-blocked touch to engine
- feat(Windowing): size tooltip/popup windows to their content
- feat(Windowing): restructure multi-window hosts per archetype
- feat(flex_overflow): dynamic DPI overflow strategy with testing API and unit tests
- feat(Embedding): support engine flags via module.json5 metadata
- feat(Viewport): add display corner radii support on OHOS; force alpha to one for opaque RGBX_8888 buffers
- feat(ohos): 完善 GPU 资源回收全流程日志埋点

### 变更

- 【3.44】change(Template): 更新oh flutter图标
- 【3.44】change(Template): OHOS模板targetSdkVersion升级至26.0.0并统一compatibleSdkVersion至5.0.5(17)
- 【3.44】规范多窗口napi代码; 多窗口C++层代码瘦身与napi失败路径整改
- fix: 多窗口锚定宿主自治重构&窗口规范适配
- fix: Refactor input method pre-input display

### 修复

- 【3.44】fix(Widgets): expose dismissible ModalBarrier semantics on OHOS
- fix(Embedding): apply system font weight scale on cold start
- fix: restrict windowing embedder to Impeller Vulkan and adapt UTs
- fix: honor embedded GIF loop count on OHOS
- fix: SystemMouseCursors on OHOS
- fix: add missing space after --unuse-bisheng and stop swallowing gn failures
- fix(FlutterView): use window effective density for viewport dpr updates
- 【3.44】(PlatformView): set width/height zeroing in hidePlatformViewHybrid
- fix cursor selection range issue
- 【3.44】fix(PlatformView): keep pv geometry when hiding to fix inappwebview scroll at zero opacity
- 【3.44】fix(PlatformView): move affine transform to a separate channel message
- fix(ohos): map custom hvigor build modes to standard flutter modes
- fix: decode negative BigInt in standard message codecs
- fix(ohos): restore plugin state after ability recreation
- fix: physicalTouchSlop missing dpr conversion, touchSlop dropped to 1.4
- 【3.44】fix(Texture): implement SurfaceTextureEntry.release() via unregisterTexture
- fix(Channel): send fallback error envelope when result decode fails; deliver error envelope when dart handler throws
- fix: unregister preview callbacks
- fix(safearea): correct safe area padding for edgeToEdge and freeform window exit
- fix: pass --route parameter to hdc aa start via --ps route Want parameter
- fix: tooltip/popup窗口deactivate销毁规范&slide闪烁与resize修复
- fix(hcpp): 【3.44】Fix the HCPP switch to enable correct texture z-order sequencing
- fix(memory_leak): Fix some memory leakage issues related to HarmonyOS adaptation
- fix(Accessibility): expose OHOS semantics to UiTest
- Fix PlatformView touch/mouse/axis coordinate space errors and left-click offset on windowed HarmonyOS PC
- fix: Adapt the DevEco signature configuration to the new version
- Solve the problem of abnormal coordinate distribution for platformview click events under dynamic dpi
- 【3.44】修复StandardMessageCodec.writeValueInternal 绕过子类覆写导致序列化失败
- fix: Fix the total frame count issue during sliding frame drops
- 【3.44】修复channel传递递归数据导致jscrash
- postInputEventWithStrategy支持失败回落postInputEvent
- 更新 FlutterPage.ets 取消 flutterView 断言，避免 crash
- fix(ohos): bundle NativeAssetsManifest.json into flutter_assets to align with android
- fix(input): 修复多引擎场景FlutterView#onWindowCreated未调用,导致输入法弹起时keyboardHeightChangeCallback不执行的问题
- fix(PlatformView): 【3.44】rename viewId to ohosHcppViewId to avoid subclass name conflicts

## Changelog

- [CHANGELOG_OHOS.md](../CHANGELOG_OHOS.md#version20261024)

## 资料文档

- [文档](https://gitcode.com/CPF-Flutter/flutter_samples/blob/master/docs/ohos/README.md)
