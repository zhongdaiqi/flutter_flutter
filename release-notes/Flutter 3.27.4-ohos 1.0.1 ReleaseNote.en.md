## Version Overview
This version is an OpenHarmony version based on Flutter 3.27.4. This version supports and improves the capabilities of the OpenHarmony platform and improves stability.

## Bugfix
- When rendering images beyond the texture range, do not use scalePixels to accelerate the rendering of large images
- When the flutter input box contains default English characters, when switching the input box, the soft keyboard candidate words will not be updated
- Fixed the Channel memory leak issue
- Solve the problem of log screen flooding in debug mode when the watchdog function is introduced
- Fixed the issue of appfreeze when debugging dart code in debug mode
- Fix FlutterAssets getAssetFilePathByName with bundleName not working
- Fixed the issue where mouse/two-finger swiping could not scroll when using multiple web pages
- bottomRect reports an undefined issue
- Fixed the white border issue of drawclirle
- Solve the problems that may cause the image source uaf
- Fixed the issue where calling the setWindowLayoutFullScreen interface on a PC does not take effect
- LTPO enabled by default
- Fixed the Hover exception issue in Flutter WebView
- When compiling and uploading debug engine products, the default setting is to not use the unptimized option

## Release Date
Nov 4, 2025

## Version Compatibility
- Minimum Engine Build API: **OpenHarmony API 20**
- Target App Build API: **OpenHarmony API 20**
- Minimum App Runtime API: **OpenHarmony API 12**
- Flutter SDK: **3.27.4-ohos-1.0.1** (Due to Flutter version parsing rules, to avoid version comparison failures, it will display as 3.27.5-ohos-1.0.1)

## Changelog
- [3.27.4-ohos-1.0.1](../CHANGELOG_OHOS.md)

## Enabling Documentation
- [Documentation Link](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
