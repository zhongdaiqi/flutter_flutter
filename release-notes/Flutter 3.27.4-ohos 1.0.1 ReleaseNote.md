## 版本概述
本版本为基于Flutter 3.27.4适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## Bug修复
- impeller渲染超出纹理范围图片时，不走scalePixels，加速大图渲染
- flutter输入框存在默认英文字符时，切换输入框，软键盘候选词不更新
- 修复Channel内存泄漏问题
- 解决看门狗功能引入的debug模式下日志刷屏问题
- 解决debug模式下调试dart代码出现appfreeze
- Fix FlutterAssets getAssetFilePathByName with bundleName not working
- 修复多web时，鼠标/双指滑动无法滚动的问题
- bottomRect报undefined
- 修复drawclirle白边问题
- 解决可能会导致image_source uaf的问题
- 修复PC调用setWindowLayoutFullScreen接口不生效的问题
- 默认LTPO开启
- 修复Flutter WebView中Hover异常问题
- 编译和上传debug引擎产物时，默认改为不使用unoptimized选项

## 版本发布时间
2025年11月4日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 20**
- 应用构建目标 API：**OpenHarmony API 20**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.27.4-ohos-1.0.1**（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.27.5-ohos-1.0.1）

## Changelog
- [3.27.4-ohos-1.0.1](../CHANGELOG_OHOS.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
