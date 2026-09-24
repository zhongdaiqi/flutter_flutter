# Flutter 3.22.3+ohos-1.1.6 Release Notes

> **版本状态**：release<br/>
> **发布日期**：2026-09-24<br/>
> **Flutter 上游社区基线版本**：[![Flutter Version](https://img-transfer.gitcode.com?p=https%3A%2F%2Fimg.shields.io%2Fbadge%2FFlutter-3.22.3-blue.svg%3Flogo%3Dflutter&projectId=CPF-Flutter&pageUrl=https%3A%2F%2Fgitcode.com%2FCPF-Flutter)](https://github.com/flutter/flutter/commit/5dcb86f68f239346676ceb1ed1ea385bd215fba1)

---

## 版本概述

本版本为 Flutter OpenHarmony 平台 1.1.6 Release 版本，基于 Flutter 3.22.3 版本适配。本版本新增动态 DPI 溢出策略、版本解析支持 +ohos 构建元数据标签格式、GPU 资源回收与白屏渲染 DFX 日志埋点等特性，并将 OHOS 模板 targetSdkVersion 升级至 26.0.0、更新应用模板默认图标；同时修复了 StandardMessageCodec 序列化、channel 递归数据 JSCrash、内存泄漏、输入法、无障碍等多方面问题。

## 版本配套

| 配套               | 版本                                                         | 说明                                                         |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Flutter SDK        | [3.22.3+ohos-1.1.6](https://gitcode.com/CPF-Flutter/flutter_flutter/tree/3.22.3+ohos-1.1.6) | 版本号采用 `+ohos` build metadata 格式                       |
| DevEco Studio      | DevEco Studio 26.0.0 Release                                 | 开发工具（IDE），[前往下载](https://developer.huawei.com/consumer/cn/download/deveco-studio) |
| Command Line Tools | Command Line Tools 26.0.0 Release                            | 开发工具集，[前往下载](https://developer.huawei.com/consumer/cn/download/command-line-tools-for-hmos) |
| 引擎构建最低 SDK   | 26.0.0                                                       | 配置 `DEVECO_SDK_HOME` 环境变量指向 SDK 路径                 |
| 应用编译最低 SDK   | 26.0.0                                                       | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compileSdkVersion": "26.0.0" |
| 应用运行最低 SDK   | 5.0.5(17)                                                    | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compatibleSdkVersion": "5.0.5(17)" |

## 主要变更

### 新增

- feat(flex_overflow): dynamic DPI overflow strategy with testing API and unit tests
- feat: parseOhosVersion supports +ohos build metadata tag format
- feat(ohos): 完善 GPU 资源回收全流程日志埋点
- add:白屏渲染相关dfx日志

### 变更

- 【3.22】change(Template): OHOS模板targetSdkVersion升级至26.0.0并统一compatibleSdkVersion至5.0.5(17)
- 【3.22】change(Template): 更新oh flutter图标

### 修复

- 【3.22】修复StandardMessageCodec.writeValueInternal 绕过子类覆写导致序列化失败
- fix:Fix the total frame count issue during sliding frame drops
- 【3.22】修复channel传递递归数据导致jscrash
- Solve the problem of abnormal coordinate distribution for platformview click events under dynamic dpi
- fix(ohos): restore plugin state after ability recreation
- fix: physicalTouchSlop missing dpr conversion, touchSlop dropped to 1.4
- 【3.22】fix(Texture): implement SurfaceTextureEntry.release() via unregisterTexture
- fix(Channel): deliver error envelope when dart handler throws and send fallback error envelope when result decode fails
- fix: unregister preview callbacks
- postInputEventWithStrategy支持失败回落postInputEvent
- fix(input): 修复多引擎场景FlutterView#onWindowCreated未调用,导致输入法弹起时keyboardHeightChangeCallback不执行的问题
- fix: 取消flutterView断言，避免crash
- fix(memory_leak):Fix some memory leakage issues related to HarmonyOS adaptation
- fix(Accessibility): expose OHOS semantics to UiTest
- fix: Refactor input method pre-input display
- fix(DEPS_ohos): update skia_revision for font alias fix
- fix: pass --route parameter to hdc aa start via --ps route Want parameter
- fix(integration_test): initialize OHOS test results static set

## Changelog

- [CHANGELOG.md](../CHANGELOG.md#version20260924)

## 资料文档

- [文档](https://gitcode.com/CPF-Flutter/flutter_samples/blob/master/docs/ohos/README.md)
