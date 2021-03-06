// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

library element_animate_test;

import 'dart:async';
import 'dart:html';

import 'package:async_helper/async_minitest.dart';

main() {
  test('omit timing', () {
    if (Animation.supported) {
      var body = document.body;
      var player = body.animate([
        {"transform": "translate(100px, -100%)"},
        {"transform": "translate(400px, 500px)"}
      ]);
      player.on['finish'].listen(expectAsync((_) => 'done'));
    }
  });
}
