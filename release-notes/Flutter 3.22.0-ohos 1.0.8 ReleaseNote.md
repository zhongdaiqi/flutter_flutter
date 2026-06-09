## 版本概述
本版本为基于Flutter 3.22.0适配的OpenHarmony版本。本版本支持和完善OpenHarmony平台侧能力，提升稳定性。

## 新增特性
- 增加copyResource方法中的异常捕获，增加try catch及异常日志

## Bug修复
- 修复切换输入框时，软键盘类型存在安全类键盘时出现键盘无法唤起的问题
- 分屏时在应用间输入框焦点相互切换，切至flutter输入字符后候选词显示位置有误
- 解决attach异步以及多输入框候选词跟随的问题
- 优化候选词位置为光标的右下角，修改获取坐标方式
- 修复多个flutterview情况下，鼠标和手势事件分发错误的问题
- 解决上下分屏打开固定态软键盘后切换左右分屏页面上缩问题
- 修改IplrVkResMgr和IplrVkFenceWait线程的优先级变动逻辑为只在OHOS_MEMORY_LEVEL_CRITICAL
- 当系统触发低内存事件时，提高IplrVkFenceWait和IplrVkResMgr线程的优先级
- 解决debug模式下调试dart代码出现appfreeze
- 修改image黑色背景的问题
- 修改HAR_VERSION的提示等级
- 修复Channel内存泄漏问题

## 版本发布时间
2025年12月25日

## 版本配套
- 引擎构建最低要求 API：**OpenHarmony API 20**
- 应用构建目标 API：**OpenHarmony API 20**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.22.0-ohos-1.0.8**（由于flutter版本解析规则，为了避免版本比较解析失败，将显示为3.22.1-ohos-1.0.8）

## Changelog
- [6.0.3.21, 6.0.3.20, 6.0.3.17, 6.0.2.125, 6.0.2.122, 6.0.2.121](../CHANGELOG.md)

## 赋能文档
- [文档链接](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)