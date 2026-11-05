// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart' hide TypeMatcher, isInstanceOf;

void main() {
  group('scrolling performance test', () {
    late FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();

      await driver.waitUntilFirstFrameRasterized();
    });

    tearDownAll(() async {
      driver.close();
    });

    Future<void> scrollAction(String listKey) async {
      final SerializableFinder list = find.byValueKey(listKey);
      expect(list, isNotNull);

      for (int i = 0; i < 5; i += 1) {
        await driver.scroll(list, 0.0, -300.0, const Duration(milliseconds: 300));
        await Future<void>.delayed(const Duration(milliseconds: 500));
      }

      for (int i = 0; i < 5; i += 1) {
        await driver.scroll(list, 0.0, 300.0, const Duration(milliseconds: 300));
        await Future<void>.delayed(const Duration(milliseconds: 500));
      }
    }

    test('complex_layout_scroll_perf', () async {
      await Future<void>.delayed(const Duration(milliseconds: 250));

      // The VM timeline ring buffer holds ~32k events. With every stream
      // enabled, the API stream alone fills it within the first ~300ms (one
      // event per C-API string marshaling call), so every Frame and raster
      // event of the scroll action is dropped and TimelineSummary finds
      // nothing to summarize. Record only the streams the summary reads.
      final Timeline timeline = await driver.traceAction(
        () => scrollAction('complex-scroll-bad'),
        streams: const <TimelineStream>[
          TimelineStream.dart,
          TimelineStream.embedder,
          TimelineStream.gc,
          TimelineStream.isolate,
          TimelineStream.vm,
        ],
      );

      final TimelineSummary summary = TimelineSummary.summarize(timeline);
      await summary.writeTimelineToFile('complex_layout_scroll_perf', pretty: true);
    }, timeout: Timeout.none);
  });
}
