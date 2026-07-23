## 版本概述
本版本为基于Flutter 3.7.12适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 发布范围
OpenHarmony API 16

## BugFix
- 修复当先执行DetachFlutterEngine，后执行OnSurfaceDestroy时NativeWindow中的内存泄露
- 修复某些场景下外接纹理生产端死锁
- 修正外接纹理第一帧背景色颜色格式为ABGR
- 修复某些场景下，切换应用后闪烁的问题
- 修复外接键盘时，同时按shift加方向键文字被删除的问题

## 版本发布时间
2025年5月21日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 16**
- 应用构建目标 API：**OpenHarmony API 16**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.7.12-ohos-1.1.1**

## Changelog
- [5.1.0.403SP1](../CHANGELOG.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-sig/flutter_samples/tree/master/ohos/docs)