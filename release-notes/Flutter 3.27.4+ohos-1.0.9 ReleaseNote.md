# Flutter 3.27.4+ohos-1.0.9 Release Notes

> **版本状态**：release<br/>
> **发布日期**：2026-09-24<br/>
> **Flutter 上游社区基线版本**：[![Flutter Version](https://img-transfer.gitcode.com?p=https%3A%2F%2Fimg.shields.io%2Fbadge%2FFlutter-3.27.4-blue.svg%3Flogo%3Dflutter&projectId=CPF-Flutter&pageUrl=https%3A%2F%2Fgitcode.com%2FCPF-Flutter)](https://github.com/flutter/flutter/commit/d8a9f9a52e5af486f80d932e838ee93861ffd863)

---

## 版本概述

本版本为 Flutter OpenHarmony 平台 1.0.9 Release 版本，基于 Flutter 3.27.4 版本适配。本版本在 1.0.8 的基础上新增白屏渲染与 GPU 资源回收相关 DFX 日志埋点及动态 DPI 下 Flex 溢出策略，版本号采用 `+ohos` build metadata 格式，更新 OH Flutter 模板默认 targetSdkVersion 至 26.0.0 及模板应用图标，同时修复消息序列化、channel 递归数据崩溃、纹理与内存泄漏、输入法预上屏与触摸事件分发、route 参数传递等多方面问题，进一步提升稳定性与兼容性。

## 版本配套

| 配套 | 版本 | 说明 |
| --- | --- | --- |
| Flutter SDK | [3.27.4+ohos-1.0.9](https://gitcode.com/CPF-Flutter/flutter_flutter/tree/3.27.4+ohos-1.0.9) | 版本号采用 `+ohos` build metadata 格式 |
| DevEco Studio | DevEco Studio 26.0.0 Release                                 | 开发工具（IDE），[前往下载](https://developer.huawei.com/consumer/cn/download/deveco-studio) |
| Command Line Tools | Command Line Tools 26.0.0 Release                            | 开发工具集，[前往下载](https://developer.huawei.com/consumer/cn/download/command-line-tools-for-hmos) |
| 引擎构建最低 SDK | 26.0.0 | 配置 `DEVECO_SDK_HOME` 环境变量指向 SDK 路径 |
| 应用编译最低 SDK | 26.0.0 | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compileSdkVersion": "26.0.0" |
| 应用运行最低 SDK | 5.0.5(17) | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compatibleSdkVersion": "5.0.5(17)" |

## 主要变更

### 新增

- add:白屏渲染相关dfx日志
- feat(ohos): 完善 GPU 资源回收全流程日志埋点
- feat(flex_overflow): dynamic DPI overflow strategy with testing API and unit tests

### 变更

- feat: parseOhosVersion supports +ohos build metadata format
- 【3.27】change(Template): OHOS模板targetSdkVersion升级至26.0.0并统一compatibleSdkVersion至5.0.5(17)
- 【3.27】change(Template): 更新oh flutter图标

### 修复

- fix: pass --route parameter to hdc aa start via --ps route Want parameter
- fix(integration_test): initialize OHOS test results static set
- fix(Accessibility): expose OHOS semantics to UiTest
- fix(DEPS_ohos): update skia_revision for font alias fix
- fix: Refactor input method pre-input display
- fix(memory_leak):Fix some memory leakage issues related to HarmonyOS adaptation
- postInputEventWithStrategy支持失败回落postInputEvent
- fix(input): 修复多引擎场景FlutterView#onWindowCreated未调用,导致输入法弹起时keyboardHeightChangeCallback不执行的问题
- fix: 取消flutterView断言，避免crash #1439
- fix(Channel): deliver error envelope when dart handler throws
- fix: unregister preview callbacks
- 【3.27】fix(Texture): implement SurfaceTextureEntry.release() via unregisterTexture
- 【3.27】修复channel传递递归数据导致jscrash
- fix: physicalTouchSlop missing dpr conversion, touchSlop dropped to 1.4
- Solve the problem of abnormal coordinate distribution for platformview click events under dynamic dpi
- fix(ohos): restore plugin state after ability recreation
- fix: Fix the total frame count issue during sliding frame drops
- 【3.27】fix: StandardMessageCodec.writeValueInternal bypassing subclass override causing serialization failure

## Changelog

- [CHANGELOG_OHOS.md](../CHANGELOG_OHOS.md#version20260924)

## 资料文档

- [文档](https://gitcode.com/CPF-Flutter/flutter_samples/blob/master/docs/ohos/README.md)
