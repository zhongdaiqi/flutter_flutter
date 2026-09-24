# Flutter 3.35.7+ohos-1.0.5 Release Notes

> **版本状态**：release<br/>
> **发布日期**：2026-09-24<br/>
> **Flutter 上游社区基线版本**：[![Flutter Version](https://img-transfer.gitcode.com?p=https%3A%2F%2Fimg.shields.io%2Fbadge%2FFlutter-3.35.7-blue.svg%3Flogo%3Dflutter&projectId=CPF-Flutter&pageUrl=https%3A%2F%2Fgitcode.com%2FCPF-Flutter)](https://github.com/flutter/flutter/commit/adc901062556672b4138e18a4dc62a4be8f4b3c2)

---

## 版本概述

本版本为 Flutter OpenHarmony 平台 1.0.5 Release 版本，基于 Flutter 3.35.7 版本适配。本版本支持动态 DPI 溢出策略、GPU 资源回收日志埋点、白屏渲染 DFX 日志等特性，parseOhosVersion 支持 +ohos build metadata 格式，OHOS 模板 targetSdkVersion 升级至 26.0.0，并修复 Channel 序列化、纹理释放、安全区域、输入法、内存泄漏等多项问题。

## 版本配套

| 配套 | 版本 | 说明 |
| --- | --- | --- |
| Flutter SDK | [3.35.7+ohos-1.0.5](https://gitcode.com/CPF-Flutter/flutter_flutter/tree/3.35.7+ohos-1.0.5) | 版本号采用 `+ohos` build metadata 格式 |
| DevEco Studio | DevEco Studio 26.0.0 Release                                 | 开发工具（IDE），[前往下载](https://developer.huawei.com/consumer/cn/download/deveco-studio) |
| Command Line Tools | Command Line Tools 26.0.0 Release                            | 开发工具集，[前往下载](https://developer.huawei.com/consumer/cn/download/command-line-tools-for-hmos) |
| 引擎构建最低 SDK | 26.0.0 | 配置 `DEVECO_SDK_HOME` 环境变量指向 SDK 路径 |
| 应用编译最低 SDK | 26.0.0 | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compileSdkVersion": "26.0.0" |
| 应用运行最低 SDK | 5.0.5(17) | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compatibleSdkVersion": "5.0.5(17)" |

## 主要变更

### 新增

- feat(flex_overflow): dynamic DPI overflow strategy，修复动态DPI下PlatformView点击事件坐标分布异常
- feat: parseOhosVersion supports +ohos build metadata format
- feat(ohos): 完善GPU资源回收全流程日志埋点
- add:白屏渲染相关dfx日志

### 变更

- 【3.35】change(Template): OHOS模板targetSdkVersion升级至26.0.0并统一compatibleSdkVersion至5.0.5(17)
- 【3.35】change(Template): 更新oh flutter图标

### 修复

- 【3.35】修复StandardMessageCodec.writeValueInternal绕过子类覆写导致序列化失败
- fix:Fix the total frame count issue during sliding frame drops
- 【3.35】修复channel传递递归数据导致jscrash
- fix(ohos): restore plugin state after ability recreation
- fix: physicalTouchSlop missing dpr conversion, touchSlop dropped to 1.4
- 【3.35】fix(Texture): implement SurfaceTextureEntry.release() via unregisterTexture
- fix(Channel): send fallback error envelope when result decode fails, deliver error envelope when dart handler throws
- fix: unregister preview callbacks, postInputEventWithStrategy支持失败回落postInputEvent
- fix(safearea): correct safe area padding for edgeToEdge and freeform window exit
- fix: pass --route parameter to hdc aa start via --ps route Want parameter
- fix(memory_leak):Fix some memory leakage issues related to HarmonyOS adaptation
- fix(DEPS_ohos): update skia_revision for font alias fix
- fix(Accessibility): expose OHOS semantics to UiTest
- fix: Refactor input method pre-input display
- fix: 取消flutterView断言，避免crash
- fix(input): 修复多引擎场景FlutterView#onWindowCreated未调用,导致输入法弹起时keyboardHeightChangeCallback不执行的问题
- Fix incorrect deadline time in DartVM
- fix(integration_test): initialize OHOS test results static set

## Changelog

- [CHANGELOG_OHOS.md](../CHANGELOG_OHOS.md#version20260924)

## 资料文档

- [文档](https://gitcode.com/CPF-Flutter/flutter_samples/blob/master/docs/ohos/README.md)
