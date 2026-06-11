## Version Overview
This version is an OpenHarmony version based on Flutter 3.7.12. This version supports and improves the capabilities of the OpenHarmony platform and improves stability.

## New Features
- Support for hot reloading of system fonts
- Changed the position of suggested words during input to the lower right corner of the cursor
- The system font configuration is obtained from the system interface first and then from the JSON file

## BugFix
- Solved the problem of DeltaTextInputClient carry-back and delete operations being exceptional
- Fixed an issue where didChangeAppLifecycleState toggle multitasking did not perform in the background
- Fixed an issue where the lifecycle was abnormal in the case of multiple FlutterEntries
- Resolved the issue that the external keyboard of the API 20 device could not be input
- Fixed the issue of vertical video playback reversing on the emulator
- Fixed the issue of hover abnormalities caused by mouse click events
- Resolved an issue where the keyboard could not be stowed away during soft jumps
- Fixed a critical memory leak issue with webview regarding NodeController
- Fixed an issue where the routerPageUpdate listener was added and removed from FlutterView

## Version Release Time
Aug 15, 2025

## Version Support
- Minimum Engine Build API: **OpenHarmony API 20**
- Target App Build API: **OpenHarmony API 20**
- Minimum App Runtime API: **OpenHarmony API 12**
- Flutter SDK: **3.7.12-ohos-1.1.5**

## Changelog
- [6.0.0.504, 6.0.0.503, 5.1.0.601, 6.0.0.402](../CHANGELOG.md)

## Enablement Documents
- [Document Link](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
