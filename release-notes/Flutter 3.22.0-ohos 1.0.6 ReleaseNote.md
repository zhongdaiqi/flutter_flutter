## 版本概述
本版本为基于Flutter 3.22.0适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- 新增三方输入法应用反控Flutter输入框的接口适配
- impeller渲染超出纹理范围图片时，不走scalePixels，加速大图渲染
- 新增ui卡死检测上报
- 适配webview鼠标hover功能

## Bug修复
- 解决可选择文本组件无法滑动问题
- 修复FlutterEntry缺少系统环境变化监听的问题
- 解决由于时序问题，导致输入法在同步方法中调用异步粘贴方法，错误插入旧剪贴板数据
- 解决bottomRect of undefined的问题
- 修复外接纹理情况下，无法抛滑问题
- 修复DeltaTextInputClient回车和删除操作异常的问题

## 版本发布时间
2025年9月4日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 20**
- 应用构建目标 API：**OpenHarmony API 20**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.22.0-ohos-1.0.6**（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.22.1-ohos-1.0.6）

## Changelog
- [6.0.0.603, 6.0.0.602, 6.0.0.600](../CHANGELOG.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)