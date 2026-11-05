# Flutter 3.27.4+ohos-1.1.1-beta Release Notes

> **版本状态**：beta<br/>
> **发布日期**：2026-10-24<br/>
> **Flutter 上游社区基线版本**：[![Flutter Version](https://img-transfer.gitcode.com?p=https%3A%2F%2Fimg.shields.io%2Fbadge%2FFlutter-3.27.4-blue.svg%3Flogo%3Dflutter&projectId=CPF-Flutter&pageUrl=https%3A%2F%2Fgitcode.com%2FCPF-Flutter)](https://github.com/flutter/flutter/commit/d8a9f9a52e5af486f80d932e838ee93861ffd863)

---

## 版本概述

本版本为 Flutter OpenHarmony 平台 1.1.1 beta 版本，基于 Flutter 3.27.4 版本适配。本版本在 1.0.9 的基础上重点修复 PlatformView 触摸/鼠标/坐标轴事件坐标系与窗口态 PC 左键偏移、光标选区范围、SystemMouseCursors、嵌入式 GIF 循环次数、冷启动系统字重缩放、视口 DPR 密度更新、标准消息编解码负数 BigInt 解码及 PlatformView 仿射变换独立平台消息处理等问题，进一步提升 PC 端与多窗口场景下的稳定性与兼容性。

## 版本配套

| 配套 | 版本 | 说明 |
| --- | --- | --- |
| Flutter SDK | [3.27.4+ohos-1.1.1-beta](https://gitcode.com/CPF-Flutter/flutter_flutter/tree/3.27.4+ohos-1.1.1-beta) | 版本号采用 `+ohos` build metadata 格式 |
| DevEco Studio | DevEco Studio 26.0.0 Release | 开发工具（IDE），[前往下载](https://developer.huawei.com/consumer/cn/download/deveco-studio) |
| Command Line Tools | Command Line Tools 26.0.0 Release | 开发工具集，[前往下载](https://developer.huawei.com/consumer/cn/download/command-line-tools-for-hmos) |
| 引擎构建最低 SDK | 26.0.0 | 配置 `DEVECO_SDK_HOME` 环境变量指向 SDK 路径 |
| 应用编译最低 SDK | 26.0.0 | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compileSdkVersion": "26.0.0" |
| 应用运行最低 SDK | 5.0.5(17) | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compatibleSdkVersion": "5.0.5(17)" |

## 主要变更

### 修复

- fix: decode negative BigInt in standard message codecs
- fix(PlatformView): handle affine transform as a standalone platform message
- fix cursor selection range issue
- fix: SystemMouseCursors on OHOS
- fix(FlutterView): use window effective density for viewport dpr updates
- Fix PlatformView touch/mouse/axis coordinate space errors and left-click offset on windowed HarmonyOS PC
- fix: honor embedded GIF loop count on OHOS
- fix(Embedding): apply system font weight scale on cold start

## Changelog

- [CHANGELOG_OHOS.md](../CHANGELOG_OHOS.md#version20261024)

## 资料文档

- [文档](https://gitcode.com/CPF-Flutter/flutter_samples/blob/master/docs/ohos/README.md)
