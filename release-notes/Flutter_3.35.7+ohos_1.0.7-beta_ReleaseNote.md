# Flutter 3.35.7+ohos-1.0.7-beta Release Notes

> **版本状态**：beta<br/>
> **发布日期**：2026-10-24<br/>
> **Flutter 上游社区基线版本**：[![Flutter Version](https://img-transfer.gitcode.com?p=https%3A%2F%2Fimg.shields.io%2Fbadge%2FFlutter-3.35.7-blue.svg%3Flogo%3Dflutter&projectId=CPF-Flutter&pageUrl=https%3A%2F%2Fgitcode.com%2FCPF-Flutter)](https://github.com/flutter/flutter/commit/adc901062556672b4138e18a4dc62a4be8f4b3c2)

---

## 版本概述

本版本为 Flutter OpenHarmony 平台 1.0.7-beta 版本，基于 Flutter 3.35.7 版本适配。本版本增强升级工具链能力，支持升级到最新 OHOS 稳定版本标签并优先采用 +ohos 标签命名；修复 PC 端 PlatformView 坐标空间与仿射变换、鼠标光标与文本选择范围、标准消息编解码器 BigInt 解码、GIF 循环次数、冷启动字重、视口密度、无障碍语义、DevEco 签名配置与 hvigor 构建模式等多项问题。

## 版本配套

| 配套 | 版本 | 说明 |
| --- | --- | --- |
| Flutter SDK | [3.35.7+ohos-1.0.7-beta](https://gitcode.com/CPF-Flutter/flutter_flutter/tree/3.35.7+ohos-1.0.7-beta) | 版本号采用 `+ohos` build metadata 格式 |
| DevEco Studio | DevEco Studio 26.0.0 Release | 开发工具（IDE），[前往下载](https://developer.huawei.com/consumer/cn/download/deveco-studio) |
| Command Line Tools | Command Line Tools 26.0.0 Release | 开发工具集，[前往下载](https://developer.huawei.com/consumer/cn/download/command-line-tools-for-hmos) |
| 引擎构建最低 SDK | 26.0.0 | 配置 `DEVECO_SDK_HOME` 环境变量指向 SDK 路径 |
| 应用编译最低 SDK | 26.0.0 | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compileSdkVersion": "26.0.0" |
| 应用运行最低 SDK | 5.0.5(17) | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compatibleSdkVersion": "5.0.5(17)" |

## 主要变更

### 新增

- 【3.35】feat(Upgrade): support upgrading to the latest OHOS stable release tag

### 修复

- 【3.35】fix(Embedding): apply system font weight scale on cold start
- 【3.35】fix(Widgets): expose dismissible ModalBarrier semantics on OHOS
- fix: honor embedded GIF loop count on OHOS
- Fix PlatformView touch/mouse/axis coordinate space errors and left-click offset on windowed HarmonyOS PC
- fix: Adapt the DevEco signature configuration to the new version
- fix: add missing space after --unuse-bisheng and stop swallowing gn failures
- fix(FlutterView): use window effective density for viewport dpr updates
- fix(Upgrade): prefer the +ohos tag naming over the legacy -ohos one
- fix: SystemMouseCursors on OHOS
- fix cursor selection range issue
- 【3.35】fix(PlatformView): move affine transform to a separate channel message
- fix: decode negative BigInt in standard message codecs
- fix(ohos): map custom hvigor build modes to standard flutter modes

## Changelog

- [CHANGELOG_OHOS.md](../CHANGELOG_OHOS.md#version20261024)

## 资料文档

- [文档](https://gitcode.com/CPF-Flutter/flutter_samples/tree/master/ohos/docs)
