## 版本概述
本版本为Flutter OpenHarmony平台0.1.0版本（Beta），基于Flutter 3.27.4版本适配。本版本支持和完善OpenHarmony平台侧能力，提供平台化Channel、外接纹理、云端SDK等特性，并优化性能。

## 基础特性
- 支持OpenHarmony平台Flutter Channel
- 支持OpenHarmony平台Flutter Engine
- 支持OpenHarmony平台Flutter命令行工具
- 支持外接纹理
- 支持云端SDK

## 新增特性
- flutter_embedding支持ets产物和native产物分开引用
- 新增单独上传flutter.har和symbols.zip的脚本
- 增加查询ltpo开启状态的接口
- 添加DEP_ohos，依赖三方库分仓构建
- 优化帧率投票；新增纹理投票
- 重构轴事件处理，适配更多场景

## Bug修复
- 修复MediaQuery.of(context).accessibleNavigation状态值异常
- 修正轴事件API版本
- 解决ltpo使能下，外接纹理的页面上60和120帧率来回跳变
- 修改超大gif图场景的内存泄露问题
- 更改xcomponentMap_mutex为可重入锁
- 修复外接物理键盘,用中文输入法输入内容后按删除键,导致额外删除输入框中的字符的问题
- 修复web应用启动时，平台识别异常

## 版本发布时间
2025年7月17日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 20**
- 应用构建目标 API：**OpenHarmony API 20**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK： **3.27.4-ohos-0.1.0**（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.27.5-ohos-0.1.0-Beta1）

## Changelog 
- [3.27.4-ohos-0.1.0](../CHANGELOG_OHOS.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
