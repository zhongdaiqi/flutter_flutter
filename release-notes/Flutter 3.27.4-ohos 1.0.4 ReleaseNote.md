## 版本概述
本版本为基于Flutter 3.27.4适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- 在 Flutter 中导航时通知 OHOS
- 【3.27】滑动丢帧事件上报添加 FRAME_ID 属性与总帧数属性
- 增加json5文件注释特性解析支持
- LTPO增加100ms性能兜底，优化代码
- 报文时间修改为 UTC 时间戳、新增滑动丢帧上报过程中总帧数属性
- Flutter 支持 Column 自适应调整
- 滑动丢帧上报
- 同步性能雷达特性到flutter3.27版本
- 增加copyResource方法中的异常捕获，增加try catch及异常日志

## Bug修复
- 修改 napi 相关的内存泄露问题
- 修补 CIPD 缓存
- 解决上下分屏打开固定态软键盘后切换左右分屏页面上缩问题
- 修复输入框导致的闪动的问题
- 修复：快速移入移出光标时 MouseRegion 的 onExit 未触发的问题
- 修复剪切后无法粘贴的问题
- 销毁 XComponent 时发送取消事件
- 处理异常触摸事件
- 修复：预览文本替换的问题
- 修复：按下带有预览文本的 TextField 会删除预览文本的问题
- 【3.27】分屏时在应用间输入框焦点相互切换，切至 flutter 输入字符后候选词显示位置有误
- 解决 attach 异步以及多输入框候选词跟随的问题
- 修复多个 flutterview 情况下，鼠标和手势事件分发错误的问题
- 修复 LTPO 问题
- 修改 IplrVkResMgr 和 IplrVkFenceWait 线程的优先级变动逻辑为只在 OHOS_MEMORY_LEVEL_CRITICAL（可用内存极低）时提高优先级
- 当系统触发内存事件时，提高IplrVkFenceWait和IplrVkResMgr线程的优先级
- 3.27 使用 skia 渲染模式时，image 组件在部分场景下背景颜色变黑
- LTPO 默认开启逻辑错误
- 修改 HAR_VERSION 的提示等级

## 版本发布时间
2026年1月22日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 22**
- 应用构建目标 API：**OpenHarmony API 22**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.27.4-ohos-1.0.4**（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.27.5-ohos-1.0.4）

## Changelog
- [3.27.4-ohos-1.0.4](../CHANGELOG_OHOS.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)