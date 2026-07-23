## 版本概述
本版本为基于Flutter 3.7.12适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 发布范围
OpenHarmony API 16

## 新增特性
- 支持输入法输入成对符号时，光标自动调整到成对符号中间
- ohos拉起键盘的方法新增参数,传入设备类型

## BugFix
- 修复showModalBottomSheet动画失效
- 修复napi和FlutterManager内存泄露问题
- 修复主动收起软键盘，应用失焦后获焦仍会接续软键盘的问题

## 已知问题
- 外接纹理第一帧自定义背景颜色接口setTextureBackGroundColor参数格式当前为ARGB，应该为ABGR

## 版本发布时间
2025年4月28日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 16**
- 应用构建目标 API：**OpenHarmony API 16**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.7.12-ohos-1.1.0**

## Changelog
- [5.1.0.403](../CHANGELOG.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-sig/flutter_samples/tree/master/ohos/docs)