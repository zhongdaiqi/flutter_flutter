## 版本概述
本版本为基于Flutter 3.22.0适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- 系统字体配置改为先从系统接口获取再从json文件获取
- 图片编解码实现中用不拷贝内存接口替换旧接口
- 同步官方仓对impeller过大纹理限制操作
- 使用LTRB格式描述DisplayFeature的信息
- 修改flutter外接纹理buffer丢弃策略

## Bug修复
- 修复使用impeller-vulkan渲染方式，放大缩小窗口时偶现花屏的问题
- 修复platformview和flutter输入框来回点击导致flutter侧无法输入的问题
- 修复message loop中对epoll wait的重复调用
- 修复长按修饰键跨应用复制粘贴、onKeyEvent回调组合键注入模式异常的问题
- 修复api20外接键盘无法输入问题
- 修复模拟器上竖屏视频播放倒转的问题
- 修复鼠标点击事件导致的hover异常问题
- 修复nativeShellHolderId变量为null时，执行flutterNapi方法闪退问题
- 修复多FlutterEntry情况下，生命周期异常的问题
- 修复超大gif图场景的内存泄露问题
- 修复webview内存泄露问题

## 版本发布时间
2025年8月15日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 20**
- 应用构建目标 API：**OpenHarmony API 20**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.22.0-ohos-1.0.5**（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.22.1-ohos-1.0.5）

## Changelog
- [6.0.0.504, 6.0.0.503, 5.1.0.601, 6.0.0.402, 6.0.0.401](../CHANGELOG.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)