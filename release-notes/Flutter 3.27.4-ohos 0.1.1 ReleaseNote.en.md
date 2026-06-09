## Version Overview
This version is an OpenHarmony version based on Flutter 3.27.4. This version supports and improves the capabilities of the OpenHarmony platform and improves stability.

## New Features
- Replace the old interface with a non-copying memory interface in the image codec implementation
- The system font configuration is obtained from the system interface first and then from the JSON file
- Synchronize upstream community changes, no longer use encoder to handle vk_cmd_buffer

## Bugfix
- Fixed an issue where vertical video playback was reversed on the emulator
- Fixed an issue where the lifecycle was abnormal in the case of multiple FlutterEntries
- Fixed the issue of hover abnormalities caused by mouse click events
- Fixed an issue where the external keyboard on API20 devices could not be inputted
- Fixed the wrong way to use the void operator in ETS

## Release Date
Aug 15, 2025

## Version Compatibility
- Minimum Engine Build API: **OpenHarmony API 20**
- Target App Build API: **OpenHarmony API 20**
- Minimum App Runtime API: **OpenHarmony API 12**
- Flutter SDK: **3.27.4-ohos-0.1.1** (Due to Flutter version parsing rules, to avoid version comparison failures, it will display as 3.27.5-ohos-0.1.1-Beta3)

## Changelog
- [3.27.4-ohos-0.1.1](../CHANGELOG_OHOS.md)

## Enabling Documentation
- [Documentation Link](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
