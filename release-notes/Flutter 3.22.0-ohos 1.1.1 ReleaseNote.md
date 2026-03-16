## 版本概述
本版本为基于Flutter 3.22.0适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- Click the status bar to automatically return to the top
- 增加路由跳转和标签页切换的检测能力
- [impeller] Vulkan backend supports skipping rendering when dirty region is 0.
- Add monitor for external textures visible area

## Bug修复
- Addressed the issue where cropping with original dimensions in a transformed coordinate system resulted in a size mismatch.
- 修复软键盘直接弹起到界面上问题
- fix: keyboard home key is not consistent
- fix: caplock and return keys are not working with keyboard
- Fixed: onInactive method was not triggered when the WebView became invisible.
- [Impeller] match Skia's old VMA default block size.
- Fix the issue of keyboard popping up and flickering in PlatformView input box
- 修复使用multiply混合模式时，在某些GPU上画面变白/变灰的问题
- Frame gate enabled: keep draining producer queue, but do not schedule
- Fix the issue where the clipboard cannot paste content in a custom format
- [Impeller] Fixed an issue where gradient effects on HarmonyOS devices exhibited clipping. With mediump enabled by default, IPOrderedDither8x8 uint(dest.x) and uint(dest.y) might experience precision loss on some GPU chips.
- 修复多PlatformView场景下输入框失焦问题
- 格式修改优化he tiaoz
- fix: false error log when notify page change successfully
- Set VMA default block size.
- Fix cache errors related to YUVConversionVK.

## 版本发布时间
2026年3月16日

## 版本配套
- OpenHarmony API20
- Flutter SDK: 3.22.0-ohos-1.1.1（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.22.1-ohos-1.1.1）

## Changelog
- [3.22.0-ohos-1.1.1](../CHANGELOG.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)