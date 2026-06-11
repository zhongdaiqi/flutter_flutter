## Version Overview
This version is an OpenHarmony version based on Flutter 3.22.0. This version supports and improves the capabilities of the OpenHarmony platform and improves stability.

## New Features
- The Flutter SDK template project and test project are adapted to API 18
- Added the EXIF rotation feature for image decoding adaptation
- Added support for partial refresh of external textures
- Added the ability to access the hiAppEvent API
- Compatible with trackpad sliding and sliding, two-finger pinching, and Ctrl mouse wheel zoom function
- flutter_embedding supports separate references to ETS and native products

## BugFix
- Fixed the issue that the parameters were abnormal when adding and removing routerPageUpdate listeners in FlutterView, and the listeners added by the user could be removed unexpectedly
- Fixed the issue that the bundleName parameter of getAssetFilePathByName was invalid when FlutterAssets was filed
- Fixed the multi-threaded concurrency issue that may occur during shell destruction
- Fixed the bug that occurs when compiling the engine product of ohos-x64 in Windows environment
- Fixed the issue that the status value of MediaQuery.of(context).accessibleNavigation is abnormal
- Fixed the issue that when triggering gc, touching the flutter page to manipulate XcomponentMap caused a deadlock
- Fixed the issue that when the native method called through the method channel was not implemented with the await option, the dart code was stuck

## Version Release Time
Jun 27, 2025

## Version Support
- Minimum Engine Build API: **OpenHarmony API 18**
- Target App Build API: **OpenHarmony API 18**
- Minimum App Runtime API: **OpenHarmony API 12**
- Flutter SDK: **3.22.0-ohos-1.0.4** (Due to Flutter version parsing rules, to avoid version comparison failures, it will display as 3.22.1-ohos-1.0.4)

## Changelog
- [5.1.0.503](../CHANGELOG.md)

## Enablement Documents
- [Document Link](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
