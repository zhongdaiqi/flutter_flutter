// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:complex_layout/src/app.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_driver/driver_extension.dart';

final GlobalKey<_SemanticsRebuildHostState> _hostKey = GlobalKey<_SemanticsRebuildHostState>();

/// Rebuilds the entire app subtree with a fresh key so the semantics tree
/// is regenerated from scratch, then waits for the frame that flushes the
/// semantics update.
Future<String> _handleDriverCommand(String? command) async {
  if (command != 'rebuild-semantics') {
    return 'unknown-command';
  }
  _hostKey.currentState!.rebuild();
  await SchedulerBinding.instance.endOfFrame;
  return 'ok';
}

void main() {
  enableFlutterDriverExtension(handler: _handleDriverCommand);
  runApp(_SemanticsRebuildHost(key: _hostKey));
}

class _SemanticsRebuildHost extends StatefulWidget {
  const _SemanticsRebuildHost({super.key});

  @override
  State<_SemanticsRebuildHost> createState() => _SemanticsRebuildHostState();
}

class _SemanticsRebuildHostState extends State<_SemanticsRebuildHost> {
  int generation = 0;

  void rebuild() {
    setState(() {
      generation += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: ValueKey<int>(generation), child: const ComplexLayoutApp());
  }
}
