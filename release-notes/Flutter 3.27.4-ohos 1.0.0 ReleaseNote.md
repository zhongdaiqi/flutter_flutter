## 版本概述
本版本为基于Flutter 3.27.4适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- 新增三方输入法应用反控flutter输入框的回调注册与实现
- 新增ui卡死上报
- 新增输入法字符预上屏
- 适配webview鼠标hover功能

## Bug修复
- 解决可选择文本组件无法滑动问题
- 解决bottomRect of undefined的问题
- 修复FlutterEntry缺少系统环境变化监听的问题
- 修复canvas.drawRect出现白边的情况
- 解决由于时序问题，导致输入法在同步方法中调用异步粘贴方法，错误插入旧剪贴板数据
- 修复pc下面外接纹理的抛滑问题
- 解决DeltaTextInputClient回车和删除操作异常的问题

## 版本发布时间
2025年9月4日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 20**
- 应用构建目标 API：**OpenHarmony API 20**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.27.4-ohos-1.0.0**（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.27.5-ohos-1.0.0）

## Changelog
- [3.27.4-ohos-1.0.0](../CHANGELOG_OHOS.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
