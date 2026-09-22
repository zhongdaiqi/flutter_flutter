# Changelog

## 3.47.0-ohos-0.0.1
- 基于 Flutter 3.47.0 版本进行 OHOS 适配
- 合并 oh-3.44.9-dev 分支的 OHOS 特有代码到 3.47.0 基线
- 适配上游 artifacts.dart 重构（Artifact 枚举成员方法 getFileName）
- 适配上游 build_info.dart 重构（TargetPlatform 枚举 switch 表达式语法）
- 适配上游 project.dart 新增依赖（glob、package_graph、migrations）
- 适配上游 flutter_plugins.dart 新增参数（pubspecCache、packageGraph、packageConfig）

## 3.44.9-ohos-0.0.1
- 修复ohos侧flutter --build-dir=build3 无法生成build3目录,([4e00ef11a1](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/4e00ef11a1208157ff3e14b82ed23beb80d8cd90?ref=oh-3.44.9-dev))
- 解决 flutter 编译执行其他平台产物 crash 的问题,([440167da4f](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/440167da4fd710885d879023c03e615e6170d165?ref=oh-3.44.9-dev))
- 解决 Mac 编译 engine 时 metal 侧报错问题,([850a6af3ed](https://gitcode.com/CPF-Flutter/flutter_flutter/commit/850a6af3ed708007aaaead6f3c48daa686ec36dd?ref=oh-3.44.9-dev))