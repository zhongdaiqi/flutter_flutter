## 版本概述
本版本为基于Flutter 3.27.4适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- 滑动丢帧上报
- 同步性能雷达特性到flutter3.27版本
- 增加copyResource方法中的异常捕获，增加try catch及异常日志

## Bug修复
- fix: pressing TextField with preview text would delete it
- 分屏时在应用间输入框焦点相互切换，切至flutter输入字符后候选词显示位置有误
- 解决attach异步以及多输入框候选词跟随的问题
- 修复多个flutterview情况下，鼠标和手势事件分发错误的问题
- 修改IplrVkResMgr和IplrVkFenceWait线程的优先级变动逻辑为只在OHOS_MEMORY_LEVEL_CRITICAL(可用内存极低)时提高优先级
- 当系统触发内存事件时，提高IplrVkFenceWait和IplrVkResMgr线程的优先级
- 候选词位置为光标的右下角
- 使用skia渲染模式时，image组件在部分场景下背景颜色变黑
- 修复LTPO问题
- LTPO默认开启逻辑错误
- 修改HAR_VERSION的提示等级

## 版本发布时间
2025年12月25日

## 版本配套
- OpenHarmony API20
- Flutter SDK: 3.27.4-ohos-1.0.2（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.27.5-ohos-1.0.2）

## Changelog
- [3.27.4-ohos-1.0.2](../CHANGELOG_OHOS.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
