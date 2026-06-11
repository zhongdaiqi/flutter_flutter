## Version Overview
This version is the Flutter OpenHarmony platform version 0.0.1 (Beta), based on the Flutter 3.27.4. This version supports and improves the capabilities of the OpenHarmony platform, provides platform-based channels, external texture, cloud SDKs and other features, and optimizes performance.

## Basic Features
- Support OpenHarmony platform Flutter Channel
- Support OpenHarmony platform Flutter Engine
- Support OpenHarmony platform Flutter Command line tool
- Support OpenHarmony platform External Texture
- Support OpenHarmony platform SDK

## New Features
- flutter_embedding supports separate references for ets products and native products
- Added script for separately uploading flutter.har and symbols.zip
- Added an interface to query the ltpo activation status
- Added DEP_ohos, depending on third-party library sub-repo construction
- Optimized frame rate voting; added texture voting
- Refactored axis event handling to adapt to more scenarios

## Bugfix
- Fixed the abnormal status value of MediaQuery.of(context).accessibleNavigation
- Fixed the Axis Events API version
- Solved the problem of 60 and 120 frame rates jumping back and forth on the page of external textures under LTPO enablement
- Fixed memory leakage issue in oversized gif scenes
- Changed the xcomponentMap_mutex to reentrant lock
- Fixed an issue where pressing the delete key after entering content in the Chinese input method on an external physical keyboard caused additional deletion of characters in the input box
- Fixed an abnormality in platform recognition when a web application was launched

## Release Date
July 17, 2025

## Version Compatibility
- Minimum Engine Build API: **OpenHarmony API 20**
- Target App Build API: **OpenHarmony API 20**
- Minimum App Runtime API: **OpenHarmony API 12**
- Flutter SDK: **3.27.4-ohos-0.1.0** (Due to Flutter version parsing rules, to avoid version comparison failures, it will display as 3.27.5-ohos-0.1.0-Beta1)

## Changelog
- [3.27.4-ohos-0.1.0](../CHANGELOG_OHOS.md)

## Enabling Documentation
- [Documentation Link](https://gitcode.com/openharmony-tpc/flutter_samples/tree/master/ohos/docs)
