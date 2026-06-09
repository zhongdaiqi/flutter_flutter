## Version Overview
This version is an OpenHarmony version based on Flutter 3.22.0. This version supports and improves the capabilities of the OpenHarmony platform and improves stability.

## BugFix
- Fixed the issue of log screen flooding caused by AcquireBuffer when no new frames were generated
- Fixed the Channel memory leak issue
- Fixed the issue where mouse/two-finger swiping could not scroll when using multiple web pages
- Fixed for rendering anomalies in dirty areas during pre-rendering
- Fixed the occasional bottomRect error issue
- Fixed the issue where vulkan DestroyImageView crashed when the app clicked the back button
- Handle the HarmonyOS exception touchevent
- Fixed the issue where calling the setWindowLayoutFullScreen interface on a PC does not take effect
- Solve the problems that may cause the image source uaf
- Solve the problem of deleting exceptions in delta mode
- Solve the problem of mprotect failing when listing on the app market through memory mapping
- When destroying an xcomponent, send a cancel signal to the gesture currently being processed
- When compiling and uploading debug engine products, change to default not to use the unoptimized option

## Version Release Time
Nov 4, 2025

## Version Support
- Minimum Engine Build API: **OpenHarmony API 20**
- Target App Build API: **OpenHarmony API 20**
- Minimum App Runtime API: **OpenHarmony API 12**
- Flutter SDK：**3.22.0-ohos-1.0.7** (Due to Flutter version parsing rules, to avoid version comparison failures, it will display as 3.22.1-ohos-1.0.7)

## Changelog
- [6.0.0.705, 6.0.0.704, 6.0.0.701, 6.0.0.700](../CHANGELOG.md)

## Enablement Documents
- [Document Link](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
