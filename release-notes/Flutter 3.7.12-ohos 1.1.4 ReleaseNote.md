## 版本概述
本版本为基于Flutter 3.7.12适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- flutter sdk模版工程和测试工程适配api18
- 新增接入hiAppEvent接口的能力
- 适配触控板滑动抛滑、双指捏合功能，Ctrl+鼠标滚轮缩放
- flutter_embedding支持ets和native产物分开引用 

## Bug修复
- 修复触发gc时，触摸flutter页面操作XcomponentMap时导致死锁的问题
- 修复用await选项，通过method channel调用的native方法未实现时，dart代码卡住的问题
- 修复3.7单元测试用例中，进行函数返回值断言时，调用错误函数的问题

## 版本发布时间
2025年6月27日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 18**
- 应用构建目标 API：**OpenHarmony API 18**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.7.12-ohos-1.1.4**

## Changelog
- [5.1.0.503](../CHANGELOG.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)