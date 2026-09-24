# Flutter 3.41.9+ohos-1.0.2 Release Notes

> **版本状态**：release<br/>
> **发布日期**：2026-09-24<br/>
> **Flutter 上游社区基线版本**：[![Flutter Version](https://img-transfer.gitcode.com?p=https%3A%2F%2Fimg.shields.io%2Fbadge%2FFlutter-3.41.9-blue.svg%3Flogo%3Dflutter&projectId=CPF-Flutter&pageUrl=https%3A%2F%2Fgitcode.com%2FCPF-Flutter)](https://github.com/flutter/flutter/commit/00b0c91f06209d9e4a41f71b7a512d6eb3b9c694)

---

## 版本概述

本版本为 Flutter OpenHarmony 平台 1.0.2 Release 版本，基于 Flutter 3.41.9 版本适配。本版本采用 +ohos build metadata 版本格式（与上游稳定版等价优先级），并持续完善 OpenHarmony 平台侧能力，提供平台化 Channel、外接纹理、云端 SDK 等特性，修复多项缺陷并优化性能。

## 版本配套

| 配套 | 版本 | 说明 |
| --- | --- | --- |
| Flutter SDK | [3.41.9+ohos-1.0.2](https://gitcode.com/CPF-Flutter/flutter_flutter/tree/3.41.9+ohos-1.0.2) | 版本号采用 `+ohos` build metadata 格式 |
| DevEco Studio | DevEco Studio 26.0.0 Release                                 | 开发工具（IDE），[前往下载](https://developer.huawei.com/consumer/cn/download/deveco-studio) |
| Command Line Tools | Command Line Tools 26.0.0 Release                            | 开发工具集，[前往下载](https://developer.huawei.com/consumer/cn/download/command-line-tools-for-hmos) |
| 引擎构建最低 SDK | 26.0.0 | 配置 `DEVECO_SDK_HOME` 环境变量指向 SDK 路径                 |
| 应用编译最低 SDK | 26.0.0 | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compileSdkVersion": "26.0.0" |
| 应用运行最低 SDK | 5.0.5(17) | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compatibleSdkVersion": "5.0.5(17)" |

## 主要变更

### 新增

- feat(flex_overflow): dynamic DPI overflow strategy with testing API and unit tests; Solve the problem of abnormal coordinate distribution for platformview click events under dynamic dpi
- feat: parseOhosVersion supports +ohos build metadata tag format
- feat(ohos): 完善 GPU 资源回收全流程日志埋点
- add:白屏渲染相关dfx日志

### 变更

- 【3.41】change(Template): 更新oh flutter图标
- 【3.41】change(Template): OHOS模板targetSdkVersion升级至26.0.0并统一compatibleSdkVersion至5.0.5(17)
- LTPO feature is enabled by default

### 修复

- 【3.41】修复StandardMessageCodec.writeValueInternal 绕过子类覆写导致序列化失败
- fix:Fix the total frame count issue during sliding frame drops
- 【3.41】修复channel传递递归数据导致jscrash
- fix(ohos): restore plugin state after ability recreation
- fix: Remove shared rendering data from TextFrame
- fix: physicalTouchSlop missing dpr conversion, touchSlop dropped to 1.4
- 【3.41】fix(Texture): implement SurfaceTextureEntry.release() via unregisterTexture
- fix(Channel): send fallback error envelope when result decode fails; fix(Channel): deliver error envelope when dart handler throws
- fix: unregister preview callbacks
- fix(safearea): correct safe area padding for edgeToEdge and freeform window exit
- postInputEventWithStrategy支持失败回落postInputEvent
- update: 更新文件 FlutterPage.ets 取消flutterView断言，避免crash
- fix(input): 修复多引擎场景FlutterView#onWindowCreated未调用,导致输入法弹起时keyboardHeightChangeCallback不执行的问题
- fix: pass --route parameter to hdc aa start via --ps route Want parameter
- fix(memory_leak):Fix some memory leakage issues related to HarmonyOS adaptation
- fix(Accessibility): expose OHOS semantics to UiTest
- fix: Refactor input method pre-input display
- fix(DEPS_ohos): update skia_revision for font alias and weight fixes
- Fix incorrect deadline time in DartVM
- fix(ohos): bundle NativeAssetsManifest.json into flutter_assets to align with android
- Fixed: flutter drive execution failure

## Changelog

- [CHANGELOG_OHOS.md](../CHANGELOG_OHOS.md#version20260924)

## 资料文档

- [文档](https://gitcode.com/CPF-Flutter/flutter_samples/blob/master/docs/ohos/README.md)
