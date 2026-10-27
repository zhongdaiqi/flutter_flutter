// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:integration_test/integration_test_driver.dart' as driver;

Future<void> main() => driver.integrationDriver(
  responseDataCallback: (Map<String, dynamic>? data) async {
    // When the app-side test fails, `data` is null or lacks 'performance'.
    // Report that plainly instead of crashing on a null cast.
    if (data == null || data['performance'] == null) {
      throw StateError(
        'e2e run produced no performance data; the app-side test likely failed. '
        'data=$data');
    }
    await driver.writeResponseData(
      data['performance'] as Map<String, dynamic>,
      testOutputFilename: 'e2e_perf_summary',
    );
  },
);
