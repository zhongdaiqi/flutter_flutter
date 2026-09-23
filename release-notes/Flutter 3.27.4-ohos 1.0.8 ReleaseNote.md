# Flutter 3.27.4-ohos-1.0.8 Release Notes

> **版本状态**：release<br/>
> **发布日期**：2026-08-17<br/>
> **Flutter 上游社区基线版本**：[![Flutter Version](https://img-transfer.gitcode.com?p=https%3A%2F%2Fimg.shields.io%2Fbadge%2FFlutter-3.27.4-blue.svg%3Flogo%3Dflutter&projectId=CPF-Flutter&pageUrl=https%3A%2F%2Fgitcode.com%2FCPF-Flutter)](https://github.com/flutter/flutter/commit/d8a9f9a52e5af486f80d932e838ee93861ffd863)

---

## 版本概述

本版本为 Flutter OpenHarmony 平台 1.0.8 Release 版本，基于 Flutter 3.27.4 版本适配。本版本在 1.0.7 的基础上新增 PC 端与手机端密码保险箱功能、Web 页面鼠标拖拽调整尺寸并默认开启 LTPO 特性，同时修复输入法预上屏 CJK 合并、输入法切换、折叠屏避让区域计算、WebView 嵌入旋转组件等多方面问题，进一步提升稳定性与兼容性。

## 版本配套

| 配套               | 版本                                                         | 说明                                                         |
| ------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Flutter SDK        | [3.27.4-ohos-1.0.8](https://gitcode.com/CPF-Flutter/flutter_flutter/tree/3.27.5-ohos-1.0.8) | 由于 Flutter 版本解析规则，为避免版本比较解析失败，实际显示为 `3.27.5-ohos-1.0.8` |
| DevEco Studio      | DevEco Studio 26.0.0 Release                                 | 开发工具（IDE），[前往下载](https://developer.huawei.com/consumer/cn/download/deveco-studio) |
| Command Line Tools | Command Line Tools 26.0.0 Release                            | 开发工具集，[前往下载](https://developer.huawei.com/consumer/cn/download/command-line-tools-for-hmos) |
| 引擎构建最低 SDK   | 26.0.0                                                       | 编译构建引擎产物所需的最低SDK版本                            |
| 应用编译最低 SDK   | 26.0.0                                                       | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compileSdkVersion": "26.0.0" |
| 应用运行最低 SDK   | 5.0.5(17)                                                    | 在 [build-profile.json5](https://developer.huawei.com/consumer/cn/doc/doccenter-deveco-studio/ide-hvigor-build-profile-app#section45865492619) 中配置："compatibleSdkVersion": "5.0.5(17)" |

## 主要变更

### 新增

- flutter项目Web页面，支持鼠标拖拽调整尺寸
- 支持密码保险箱功能
- LTPO feature is enabled by default

### 修复

- fix adding the webview to the rotating component makes it unclickable and unscrollable
- Fixed the issue where deleting numbers to the left would remove two at a time
- Fixed the issue of incorrect calculation of the avoidance area under the folding machine
- Fixed the issue where typing English first and then Chinese would get overwritten
- Fix the issue where entering Chinese first and then English causes the English to be duplicated
- 预加载操作执行后,将标记重置为false,避免RecreateSwapchain复用context时仍然走到预加载的判断逻辑中
- 修改FlutterView.ets中鸿蒙原生事件调用逻辑,增加isActive状态判断
- Fixed the issue with input status when switching input methods
- 修改EmbeddingNodeController.ets中可能出现的空指针问题
- 同步三方库代码，解决鸿蒙化flutter框架编译执行其他平台产物crash的问题
- Fixed: flutter drive execution failure
- 调整isActive的判断时机,修复前后台切换ets中的状态更新不及时的问题
- fix: update comment to match pre-edit CJK merge logic
- 手势未完成清除遗留
- 同步三方库代码，解决字体内存泄漏问题

## Changelog

- [CHANGELOG_OHOS.md](../CHANGELOG_OHOS.md#version20260808)

## 资料文档

- [文档](https://gitcode.com/CPF-Flutter/flutter_samples/tree/master/ohos/docs)
