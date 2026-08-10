# Flutter 3.41.9-ohos-1.0.1.candidate Release Notes

> **版本状态**：release<br/>
> **发布日期**：2026-08-08<br/>
> **Flutter 上游社区基线版本**：[![Flutter Version](https://img-transfer.gitcode.com?p=https%3A%2F%2Fimg.shields.io%2Fbadge%2FFlutter-3.41.9-blue.svg%3Flogo%3Dflutter&projectId=CPF-Flutter&pageUrl=https%3A%2F%2Fgitcode.com%2FCPF-Flutter)](https://github.com/flutter/flutter/commit/00b0c91f06209d9e4a41f71b7a512d6eb3b9c694)

---

## 版本概述

本版本为 Flutter OpenHarmony 平台 1.0.1 Release 版本，基于 Flutter 3.41.9 版本适配。本版本支持和完善 OpenHarmony 平台侧能力，提供平台化 Channel、外接纹理、云端 SDK 等特性，并优化性能。

## 版本配套

| 配套 | 版本 / 要求 |
| --- | --- |
| **Flutter SDK**          | [**3.41.9-ohos-1.0.1.candidate**](https://gitcode.com/CPF-Flutter/flutter_flutter/releases/tag/3.41.10-ohos-1.0.1)<br/>*（由于 Flutter 版本解析规则，为避免版本比较解析失败，实际显示为 `3.41.10-ohos-1.0.1`）* |
| **DevEco Studio** | **DevEco Studio 26.0.0 Beta2**<br/>`Build Version：26.0.0.621` |
| **Command Line Tools** | **Command Line Tools 26.0.0 Beta2**<br/>`Build Version：26.0.0.621` |
| **引擎构建最低要求 API** | **OpenHarmony API 26.0.0** |
| **应用目标 API** | **OpenHarmony API 26.0.0** |
| **应用最低运行 API** | **OpenHarmony API 26.0.0** |

## 主要变更

### 新增

- 支持密码保险箱功能
- [OHOS] Add async APIs for FlutterEngine spawn/destroy to prevent ANR
- feature: flutter page pause when invisible
- 分栏功能中，弹窗蒙层创建时，保存此时的焦点位置，此弹窗消失时，恢复焦点到保存的位置
- Add DMA zero-copy image decode path
- flutter项目Web页面，支持鼠标拖拽调整尺寸

### 修复

- 同步三方库代码，解决字体内存泄漏问题
- fix: DT CPP
- 手势取消清除遗留finger
- fix: update comment to match pre-edit CJK merge logic
- Fix the template syntax error problem
- 修改分栏功能获取应用图标的方式，从硬编码图片名改为通过资源id获取，避免在自定义图标文件名时失败的问题
- 调整isActive的判断时机，修复前后台切换ets中的状态更新不及时的问题
- 提高分栏功能中，弹窗消失时，主动恢复焦点的逻辑健壮性，解决当弹窗前焦点未聚焦到页面某个组件时，恢复行为异常导致卡死的问题
- [OHOS] Fix use-after-free during async shell holder destroy
- [OHOS] Fix multi-thread napi_reference_unref crash in nativeDestroyAsync
- Fixed the issue with input status when switching input methods
- [OHOS] Fix physical PlatformView text-input handoff
- Fix the issue where entering Chinese first and then English causes the English to be duplicate
- Fixed the issue where typing English first and then Chinese would get overwritten
- fix: shorter candidate would cause preview text issue
- Fixed the issue where deleting numbers to the left would remove two at a time
- 修复折叠机下避让区域计算错误问题
- fix adding the webview to the rotating component makes it unclickable and unscrollable
- fix(Impeller): add missing kB10G10R10A2UNorm Metal pixel format mapping
- 同步三方库代码，解决鸿蒙化flutter框架编译执行其他平台产物crash的问题
- [OHOS] Fix PixelMap ReadPixels temp buffer cleanup
- [OHOS] Restore PixelMap ReadPixels tight-row semantics

### 性能

- Enable static snapshot linking for OHOS debug mode
- ohos开启指针压缩
- 发送低内存警告，触发图像缓存清理

## Changelog

- [CHANGELOG_OHOS.md](../CHANGELOG_OHOS.md#version20260808)

## 资料文档

- [文档](https://gitcode.com/CPF-Flutter/flutter_samples/tree/master/ohos/docs)
