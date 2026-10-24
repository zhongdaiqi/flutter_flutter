## 版本概述
本版本为基于Flutter 3.22.0适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## Bug修复
- 修复当没有新的帧生成时，AcquireBuffer导致的日志刷屏问题
- 修复Channel内存泄漏问题
- 修复多web时，鼠标/双指滑动无法滚动的问题
- 预渲染情况下脏区渲染异常修复
- 解决偶现bottomRect报错问题
- 修复app点击返回按钮时出现vulkan DestroyImageView崩溃
- 处理鸿蒙系统异常touchevent
- 修复PC调用setWindowLayoutFullScreen接口不生效的问题
- 解决可能会导致image_source uaf的问题
- 解决delta模式下删除异常的问题
- 通过内存映射解决上架应用市场时mprotect failed的问题
- 销毁xcomponent时，对目前正在处理的手势发送cancel信号
- 编译和上传debug引擎产物时，改为默认不使用unoptimized选项

## 版本发布时间
2025年11月4日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 20**
- 应用构建目标 API：**OpenHarmony API 20**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.22.0-ohos-1.0.7**（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.22.1-ohos-1.0.7）

## Changelog
- [6.0.0.705, 6.0.0.704, 6.0.0.701, 6.0.0.700](../CHANGELOG.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)