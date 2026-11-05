// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart' hide TypeMatcher, isInstanceOf;

void main() {
  group('semantics performance test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      // Accessibility services consume semantics updates; turn them off
      // where possible so they do not add noise to the measurement.
      //
      // Clearing requires adb and only matters on Android; hosts driving
      // other targets (e.g. OHOS) have no adb and nothing to clear.
      try {
        final Process run = await Process.start(_adbPath(), const <String>[
          'shell',
          'settings',
          'put',
          'secure',
          'enabled_accessibility_services',
          'null',
        ]);
        await run.exitCode;
      } on ProcessException {
        // No adb on this host; nothing to clear for a non-Android target.
      }

      driver = await FlutterDriver.connect(printCommunication: true);
    });

    tearDownAll(() async {
      driver.close();
    });

    // While system accessibility services are attached the platform holds
    // a private semantics handle, so the driver cannot toggle semantics
    // off to isolate the initial tree creation. Measure a full semantics
    // tree rebuild triggered from the app side instead; that works
    // regardless of the device accessibility state.
    test('semantics tree rebuild', () async {
      // Let app become fully idle.
      await Future<void>.delayed(const Duration(seconds: 2));

      await driver.forceGC();

      // Enable semantics via the driver handle on clean devices; where the
      // platform already holds semantics on this command is a no-op.
      await driver.setSemantics(true);

      // Warm up so the measured rebuild reflects steady state.
      expect(await driver.requestData('rebuild-semantics'), 'ok');
      await Future<void>.delayed(const Duration(milliseconds: 250));

      final Timeline timeline = await driver.traceAction(() async {
        expect(await driver.requestData('rebuild-semantics'), 'ok');
      });

      final List<TimelineEvent> semanticsEvents = (timeline.events ?? const <TimelineEvent>[])
          .where((TimelineEvent event) => event.name == 'SEMANTICS')
          .toList();
      if (semanticsEvents.length < 2) {
        fail(
          'Expected at least two "SEMANTICS" events, got ${semanticsEvents.length}:\n$semanticsEvents',
        );
      }
      final Duration semanticsTreeRebuild = Duration(
        microseconds:
            semanticsEvents.last.timestampMicros! - semanticsEvents.first.timestampMicros!,
      );

      final String jsonEncoded = json.encode(<String, dynamic>{
        'semanticsTreeRebuild': semanticsTreeRebuild.inMilliseconds,
      });
      File(
        p.join(testOutputsDirectory, 'complex_layout_semantics_perf.json'),
      ).writeAsStringSync(jsonEncoded);
    }, timeout: Timeout.none);
  });
}

String _adbPath() {
  final String? androidHome =
      Platform.environment['ANDROID_HOME'] ?? Platform.environment['ANDROID_SDK_ROOT'];
  if (androidHome == null) {
    return 'adb';
  } else {
    return p.join(androidHome, 'platform-tools', 'adb');
  }
}
