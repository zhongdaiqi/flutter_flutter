## Version Overview
This version is an OpenHarmony version based on Flutter 3.7.12. This version supports and improves the capabilities of the OpenHarmony platform and improves stability.

## New Features
- The Flutter SDK template project and test project are adapted to API 18
- Added the ability to access the hiAppEvent API
- Compatible with trackpad sliding and sliding, two-finger pinching, and Ctrl mouse wheel zoom function
- flutter_embedding supports separate references to ETS and native products

## BugFix
- Fixed the issue that when triggering gc, touching the flutter page to manipulate XcomponentMap caused a deadlock
- Fixed the issue that when the native method called through the method channel was not implemented with the await option, the dart code was stuck
- Fixed the issue that in the 3.7 unit test case, the wrong function was called when asserting the return value of the function

## Version Release Time
Jun 27, 2025

## Version Support
- 引擎构建最低要求 API：**OpenHarmony API 18**
- 应用构建目标 API：**OpenHarmony API 18**
- 应用最低运行 API：**OpenHarmony API 12**
- Flutter SDK：**3.7.12-ohos-1.1.4**

## Changelog
- [5.1.0.503](../CHANGELOG.md)

## Enablement Documents
- [Document Link](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
