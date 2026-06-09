## Version Overview
This version is an OpenHarmony version based on Flutter 3.22.0. This version supports and improves the capabilities of the OpenHarmony platform and improves stability.

## New Features
- Add exception catching in the copyResource method, and add try catch and exception logging

## BugFix
- Fixed the issue where the soft keyboard type cannot be awakened when switching input boxes due to a security class keyboard
- Fixed the issue where the focus of the input box switched between applications during split-screen, and the candidate word display position was incorrect after switching to flutter and entering characters
- Resolve the issues of asynchronous attachment and multi input box candidate word following
- Optimize the position of candidate words to the bottom right corner of the cursor and modify the coordinate acquisition method
- Fixed the issue of incorrect distribution of mouse and gesture events in multiple FlutterView scenarios
- Resolve the issue of shrinking pages when switching between left and right split screens after opening the fixed state soft keyboard
- Modify the priority change logic of IplrVkResMgr and IplrVkFenceWait threads to only occur in OHOS.MMORY-LEVEL_CRITIAL
- When the system triggers a low memory event, increase the priority of IplrVkFenceWait and IplrVkResMgr threads
- Resolve the issue of app freeze when debugging dart code in debug mode
- The issue of modifying the black background of the image
- Modify the prompt level of HAR_VERSION
- Fix Channel Memory Leakage Issue

## Version Release Time
Dec 25, 2025

## Version Support
- Minimum Engine Build API: **OpenHarmony API 20**
- Target App Build API: **OpenHarmony API 20**
- Minimum App Runtime API: **OpenHarmony API 12**
- Flutter SDK: **3.22.0-ohos-1.0.8** (Due to Flutter version parsing rules, to avoid version comparison failures, it will display as 3.22.1-ohos-1.0.8)

## Changelog
- [6.0.3.21, 6.0.3.20, 6.0.3.17, 6.0.2.125, 6.0.2.122, 6.0.2.121](../CHANGELOG.md)

## Enablement Documents
- [Document Link](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
