## Version Overview
This version is an OpenHarmony version based on Flutter 3.22.0. This version supports and improves the capabilities of the OpenHarmony platform and improves stability.

## New Features
- Added interface adaptation for third-party input method application anti-control Flutter input box
- When impeller renders images beyond the texture range, it does not use scalePixels to speed up the rendering of large images
- Added UI stuck detection report
- Adapted to the WebView mouse hover function

## BugFix
- Addresses an issue where selectable text components cannot be swiped
- Fixed an issue where FlutterEntry lacked listeners for system environment changes
- Resolved a timing issue that caused the input method to call the asynchronous paste method in a synchronous method, incorrectly inserting old clipboard data
- Addressed the issue of bottomRect being undefined
- Fixed the problem where external textures could not be thrown or slid
- Fixed the abnormal behavior of carriage return and delete operations in DeltaTextInputClient

## Version Release Time
Sep 4, 2025

## Version Support
- Minimum Engine Build API: **OpenHarmony API 20**
- Target App Build API: **OpenHarmony API 20**
- Minimum App Runtime API: **OpenHarmony API 12**
- Flutter SDK: **3.22.0-ohos-1.0.6** (Due to Flutter version parsing rules, to avoid version comparison failures, it will display as 3.22.1-ohos-1.0.6)

## Changelog
- [6.0.0.603, 6.0.0.602, 6.0.0.600](../CHANGELOG.md)

## Enablement Documents
- [Document Link](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
