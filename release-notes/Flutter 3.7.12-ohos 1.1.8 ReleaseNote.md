## 版本概述
本版本为基于Flutter 3.7.12适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- 退后台释放DMA资降低内存
- feat: notify OHOS when navigate in Flutter
- Flutter支持Column自适应调整
- 添加hover事件

## Bug修复
- 修复NodeController和PlatformView内存泄漏
- Fix the issue of keyboard popping up and flickering in PlatformView input box
- Frame gate enabled: keep draining producer queue, but do not schedule
- fix: 3.7 uri could be empty sometime
- fix: false error log when notify page change successfully
- 修改napi相关的内存泄露问题
- fix: MouseRegion onExit is not triggered when moving the cursor in and out fast
- Send cancel event when destroy xcomponent
- Handle abnormal touch events
- 分屏时在应用间输入框焦点相互切换，切至flutter输入字符后候选词显示位置有误
- 解决attach异步以及多输入框候选词跟随的问题
- 增加copyResource方法中的异常捕获，增加try catch及异常日志
- 修复多个flutterview情况下，鼠标和手势事件分发错误的问题
- 解决上下分屏打开固定态软键盘后切换左右分屏页面上缩问题
- 优化候选词位置为光标的右下角
- 修复flutter3.7编译的release应用无法在windows模拟器上运行的问题
- 使用原子变量解决外接纹理设置pixelmap时线程冲突的问题
- 修复3.7Channel内存泄漏问题
- 修复多web时，鼠标/双指滑动无法滚动的问题
- 修复PC无法全屏的问题

## 版本发布时间
2026年3月16日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 20**
- 应用构建目标 API：**OpenHarmony API 20**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.7.12-ohos-1.1.8**

## Changelog
- [3.7.12-ohos 1.1.8](../CHANGELOG.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)