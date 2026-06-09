## 版本概述
本版本为基于Flutter 3.7.12适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- 支持系统字体热重载
- 修改输入时候选词位置为光标的右下角
- 系统字体配置改为先从系统接口获取再从json文件获取

## Bug修复
- 解决DeltaTextInputClient回车和删除操作异常的问题
- 修复didChangeAppLifecycleState切换多任务后台未执行的问题
- 修复多FlutterEntry情况下，生命周期异常的问题
- 解决api20设备外接键盘无法输入问题
- 修改模拟器上竖屏视频播放倒转的问题
- 修复鼠标点击事件导致的hover异常问题
- 解决软跳转时键盘无法收起的问题
- 修复webview关于NodeController的严重内存泄漏问题 
- 修复FlutterView中routerPageUpdate监听器的添加和移除异常问题

## 版本发布时间
2025年8月15日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 20**
- 应用构建目标 API：**OpenHarmony API 20**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.7.12-ohos-1.1.5**

## Changelog
- [6.0.0.504, 6.0.0.503, 5.1.0.601, 6.0.0.402](../CHANGELOG.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)