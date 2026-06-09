## Version Overview
This version is an OpenHarmony version based on Flutter 3.22.0. This version supports and improves the capabilities of the OpenHarmony platform and improves stability.

## New Features
- The system font configuration is obtained from the system interface first and then from the JSON file
- Replace the old interface with a non-copying memory interface in the image codec implementation
- Synchronize the official warehouse to restrict the operation of impeller oversized textures
- Describe the DisplayFeature's information in LTRB format
- Modified the flutter external texture buffer drop policy

## BugFix
- Fixed an issue where the impeller-vulkan rendering method occasionally appeared when zooming in and out of the window
- Fixed an issue where clicking back and forth between the platformview and flutter input boxes caused the flutter side to fail to enter
- Fixed repeated calls to epoll wait in message loop
- Fixed the issue of long pressing the modifier key to copy and paste across applications, and the onKeyEvent callback key combination injection mode was abnormal
- Fixed the issue that the API 20 external keyboard could not be inputted
- Fixed an issue where vertical video playback was reversed on the emulator
- Fixed the issue of hover abnormalities caused by mouse click events
- Fixed an issue where the flutterNapi method crashed when the nativeShellHolderId variable was null
- Fixed an issue where the lifecycle was abnormal in the case of multiple FlutterEntries
- Fixed a memory leak issue in the oversized gif scene
- Fixed a webview memory leak issue

## Version Release Time
Aug 15, 2025

## Version Support
- Minimum Engine Build API: **OpenHarmony API 20**
- Target App Build API: **OpenHarmony API 20**
- Minimum App Runtime API: **OpenHarmony API 12**
- Flutter SDK：**3.22.0-ohos-1.0.5** (Due to Flutter version parsing rules, to avoid version comparison failures, it will display as 3.22.1-ohos-1.0.5)

## Changelog
- [6.0.0.504, 6.0.0.503, 5.1.0.601, 6.0.0.402, 6.0.0.401](../CHANGELOG.md)

## Enablement Documents
- [Document Link](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
