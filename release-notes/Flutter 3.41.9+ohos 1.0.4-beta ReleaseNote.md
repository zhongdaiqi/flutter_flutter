# Flutter 3.41.9+ohos-1.0.4-beta Release Notes

> **版本状态**：beta<br/>
> **发布日期**：2026-10-24<br/>
> **Flutter 上游社区基线版本**：[![Flutter Version](https://img-transfer.gitcode.com?p=https%3A%2F%2Fimg.shields.io%2Fbadge%2FFlutter-3.41.9-blue.svg%3Flogo%3Dflutter&projectId=CPF-Flutter&pageUrl=https%3A%2F%2Fgitcode.com%2FCPF-Flutter)](https://github.com/flutter/flutter/commit/00b0c91f06209d9e4a41f71b7a512d6eb3b9c694)

---

## 版本概述

本版本为 Flutter OpenHarmony 平台 1.0.4-beta 版本，基于 Flutter 3.41.9 版本适配。本版本采用 +ohos build metadata 版本格式（与上游稳定版等价优先级），并持续完善 OpenHarmony 平台侧能力，提供平台化 Channel、外接纹理、云端 SDK 等特性，修复多项缺陷。

## 版本配套

| 配套 | 版本 | 说明 |
| --- | --- | --- |
| Flutter SDK | [3.41.9+ohos-1.0.4-beta](https://gitcode.com/CPF-Flutter/flutter_flutter/tree/3.41.9+ohos-1.0.4-beta) | 版本号采用 `+ohos` build metadata 格式 |
| DevEco Studio | DevEco Studio 26.0.0 Release | 开发工具（IDE），[前往下载](https://developer.huawei.com/consumer/cn/download/deveco-studio) |
| Command Line Tools | Command Line Tools 26.0.0 Release | 开发工具集，[前往下载](https://developer.huawei.com/consumer/cn/download/command-line-tools-for-hmos) |
| 引擎构建最低 SDK | 26.0.0 | 配置 `DEVECO_SDK_HOME` 环境变量指向 SDK 路径 |
| 应用编译最低 SDK | 26.0.0 | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compileSdkVersion": "26.0.0" |
| 应用运行最低 SDK | 5.0.5(17) | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compatibleSdkVersion": "5.0.5(17)" |

## 主要变更

### 新增

- feat: add --use-ccache option to ohos.py to enable ccache engine builds
- feat(Upgrade): support upgrading to the latest OHOS stable release tag

### 修复

- fix(Embedding): apply system font weight scale on cold start
- fix: honor embedded GIF loop count on OHOS
- fix: Adapt the DevEco signature configuration to the new version
- fix(Widgets): expose dismissible ModalBarrier semantics on OHOS
- Fix PlatformView touch/mouse/axis coordinate space errors and left-click offset on windowed HarmonyOS PC
- fix: SystemMouseCursors on OHOS
- fix: add missing space after --unuse-bisheng and stop swallowing gn failures
- fix(FlutterView): use window effective density for viewport dpr updates
- fix(Upgrade): prefer the +ohos tag naming over the legacy -ohos one
- fix cursor selection range issue
- fix(PlatformView): move affine transform to a separate channel message
- fix(ohos): map custom hvigor build modes to standard flutter modes
- fix: decode negative BigInt in standard message codecs

## Changelog

- [CHANGELOG_OHOS.md](../CHANGELOG_OHOS.md#version20261024)

## 资料文档

- [文档](https://gitcode.com/CPF-Flutter/flutter_samples/blob/master/docs/ohos/README.md)
