## Version Overview
This version is an OpenHarmony version based on Flutter 3.27.4. This version supports and improves the capabilities of the OpenHarmony platform and improves stability.

## New Features
- feat: notify OHOS when navigate in Flutter
- [3.27] Add FRAME_ID and total frame count attributes to jank event reporting
- Add support for parsing json5 file comments feature
- LTPO add 100ms performance fallback, optimize code
- Change report time to UTC timestamp, add total frame count attribute in jank reporting
- Flutter support Column adaptive adjustment
- Slide frame loss report
- Synchronize performance radar characteristics to Flutter3.27 version
- Add exception catching in the copyResource method, and add try catch and exception logging

## Bugfix
- Fix napi related memory leaks
- Patch cipd cache
- Fix issue where page shrinks when switching between left and right split screens after opening fixed soft keyboard in top-bottom split screen
- Fix flickering issue caused by text field
- fix: MouseRegion onExit is not triggered when moving the cursor in and out fast
- Fix the issue where pasting is not possible after cutting
- Send cancel event when destroy xcomponent
- Handle abnormal touch events
- fix: preview text replace
- fix: pressing TextField with preview text would delete it
- [3.27] When switching focus between text fields in different apps in split screen, candidate word position is incorrect after switching to Flutter and typing
- Fix attach asynchronous and candidate word following issues in multiple text fields
- Fix incorrect mouse and gesture event distribution in multiple FlutterView scenarios
- Fix LTPO issue
- Modify the logic for changing the priority of IplrVkResMgr and IplrVkFenceWait threads to only increase priority at OHOS_MEMORY_LEVEL_CRITICAL (extremely low available memory)
- When the system triggers a memory event, increase the priority of IplrVkFenceWait and IplrVkResMgr threads
- When using skia rendering mode in 3.27, image component background turns black in some scenarios
- LTPO default enable logic error
- Modify HAR_VERSION prompt level

## Release Date
Jan 22, 2026

## Version Compatibility
- OpenHarmony API20
- Flutter SDK: 3.27.4-ohos-1.0.4 (Due to Flutter version parsing rules, to avoid version comparison failures, it will display as 3.27.5-ohos-1.0.4)

## Changelog
- [3.27.4-ohos-1.0.4](../CHANGELOG_OHOS.md)

## Enabling Documentation
- [Documentation Link](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)