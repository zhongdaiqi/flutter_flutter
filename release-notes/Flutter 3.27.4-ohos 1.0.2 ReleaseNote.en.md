## Version Overview
This version is an OpenHarmony version based on Flutter 3.27.4. This version supports and improves the capabilities of the OpenHarmony platform and improves stability.

## New Features
- Slide frame loss report
- Synchronize performance radar characteristics to Flutter3.27 version
- Add exception catching in the copyResource method, and add try catch and exception logging

## Bugfix
- fix: pressing TextField with preview text would delete it
- Fixed the issue where the focus of the input box switched between applications during split-screen, and the candidate word display position was incorrect after switching to flutter and entering characters
- Resolve the issues of asynchronous attachment and multi input box candidate word following
- Fixed the issue of incorrect distribution of mouse and gesture events in multiple FlutterView scenarios
- Modify the priority change logic of IplrVkResMgr and IplrVkFenceWait threads to only increase priority when OHOS_MEMORY_LEVEL_CRITICAL(available memory is extremely low)
- When the system triggers a memory event, increase the priority of IplrVkFenceWait and IplrVkResMgr threads
- The candidate word is located in the bottom right corner of the cursor
- When using Skia rendering mode, the image component may cause the background color to turn black in some scenes
- Fix LTPO issues
- LTPO default enable logic error
- Modify the prompt level of HAR_VERSION

## Release Date
Dec 25, 2025

## Version Compatibility
- OpenHarmony API20
- Flutter SDK: 3.27.4-ohos-1.0.2 (Due to Flutter version parsing rules, to avoid version comparison failures, it will display as 3.27.5-ohos-1.0.2)

## Changelog
- [3.27.4-ohos-1.0.2](../CHANGELOG_OHOS.md)

## Enabling Documentation
- [Documentation Link](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
