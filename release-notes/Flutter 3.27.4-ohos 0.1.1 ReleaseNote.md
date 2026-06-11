## 版本概述
本版本为基于Flutter 3.27.4适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- 图片编解码实现中用不拷贝内存接口替换旧接口
- 系统字体配置改为先从系统接口获取再从json文件获取
- 同步上游社区改动，不再使用encoder处理vk_cmd_buffer

## Bug修复
- 修复模拟器上竖屏视频播放倒转的问题
- 修复多FlutterEntry情况下，生命周期异常的问题
- 修复鼠标点击事件导致的hover异常问题
- 修复api20设备外接键盘无法输入问题
- 修复ets中void运算符使用方法错误


## 版本发布时间
2025年8月15日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 20**
- 应用构建目标 API：**OpenHarmony API 20**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.27.4-ohos-0.1.1**（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.27.5-ohos-0.1.1-Beta3）

## Changelog
- [3.27.4-ohos-0.1.1](../CHANGELOG_OHOS.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
