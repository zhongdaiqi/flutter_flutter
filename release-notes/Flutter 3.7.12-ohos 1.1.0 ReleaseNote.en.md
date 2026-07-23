## Version Overview
This version is an OpenHarmony version based on Flutter 3.7.12. This version supports and improves the capabilities of the OpenHarmony platform and improves stability.

## Release Scope
OpenHarmony API 16
- When the input method is supported to input pairs of symbols, the cursor is automatically adjusted to the middle of the pairs
- Add a parameter to the method of ohos pulling up the keyboard and pass in the device type

## BugFix
- Fixed showModalBottomSheet animation missing
- Fixed the memory leak issue of napi and FlutterManager
- Fixed the issue that if the soft keyboard was actively stowed away, the focus would still continue after the application was out of focus

## Known issues
- The function of the setTextureBackGroundColor interface is to set the custom background color of the first frame of the external texture, and its parameter format should be ABGR, which is currently ARGB

## Version Release Time
April 28, 2025

## Version Support
- Minimum Engine Build API: **OpenHarmony API 16**
- Target App Build API: **OpenHarmony API 16**
- Minimum App Runtime API: **OpenHarmony API 12**
- Flutter SDK: **3.7.12-ohos-1.1.0**

## Changelog
- [5.1.0.403](../CHANGELOG.md)

## Enablement Documents
- [Document Link](https://gitcode.com/openharmony-sig/flutter_samples/tree/master/ohos/docs)
