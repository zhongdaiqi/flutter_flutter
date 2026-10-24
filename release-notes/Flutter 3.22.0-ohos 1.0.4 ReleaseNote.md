## 版本概述
本版本为基于Flutter 3.22.0适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- flutter sdk模版工程和测试工程适配api18
- 新增图片解码适配EXIF旋转特性
- 新增支持外接纹理局部刷新特性
- 新增接入hiAppEvent接口的能力
- 新增适配触控板滑动抛滑、双指捏合功能，Ctrl+鼠标滚轮缩放
- 新增flutter_embedding支持ets和native产物分开引用特性

## Bug修复
- 修正FlutterView中routerPageUpdate监听器添加和移除时参数异常的问题和可能意外移除用户所添加的监听的问题
- 修复FlutterAssets时，getAssetFilePathByName的参数bundleName无效的问题
- 修复Shell析构时可能发生的多线程并发问题
- 修复Windows环境编译ohos-x64的engine产物报错的问题
- 修复MediaQuery.of(context).accessibleNavigation状态值异常问题
- 修复触发gc时，触摸flutter页面操作XcomponentMap时导致死锁的问题
- 修复用await选项，通过method channel调用的native方法未实现时，dart代码卡住的问题

## 版本发布时间
2025年6月27日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 18**
- 应用构建目标 API：**OpenHarmony API 18**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.22.0-ohos-1.0.4**（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.22.1-ohos-1.0.4）

## Changelog
- [5.1.0.503](../CHANGELOG.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)