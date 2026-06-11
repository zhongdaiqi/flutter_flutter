## Version Overview
This version is an OpenHarmony version based on Flutter 3.27.4. This version supports and improves the capabilities of the OpenHarmony platform and improves stability.

## New Features
- Added callback registration and implementation for the third-party input method application's anti-control of Flutter input box
- Added UI freeze reporting
- Added pre-screening of input method characters
- Adapted to the WebView mouse hover function

## Bugfix
- Resolved an issue where selectable text components could not slide
- Addressed an issue with bottomRect of undefined
- Fixed an issue where FlutterEntry lacked system environment change monitoring
- Fixed white borders in canvas.drawRect
- Fixed the problem that caused the input method to call the asynchronous paste method in the synchronization method and incorrectly insert the old clipboard data due to timing issues
- Fixed the issue of slippage on external textures under the PC
- Solved the problem of DeltaTextInputClient carry-back and delete operations being exceptional

## Release Date
Sep 4, 2025

## Version Compatibility
- Minimum Engine Build API: **OpenHarmony API 20**
- Target App Build API: **OpenHarmony API 20**
- Minimum App Runtime API: **OpenHarmony API 12**
- Flutter SDK: **3.27.4-ohos-1.0.0** (Due to Flutter version parsing rules, to avoid version comparison failures, it will display as 3.27.5-ohos-1.0.0)

## Changelog
- [3.27.4-ohos-1.0.0](../CHANGELOG_OHOS.md)

## Enabling Documentation
- [Documentation Link](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
