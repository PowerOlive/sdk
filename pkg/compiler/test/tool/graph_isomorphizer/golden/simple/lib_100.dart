// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// This file was autogenerated by the pkg/compiler/tool/graph_isomorphizer.dart.

import "package:expect/expect.dart";

import 'libImport.dart';

@pragma('dart2js:noInline')
g_100() {
  Set<String> uniques = {};

  // f_1**;
  f_100(uniques, 0);
  f_101(uniques, 0);
  f_111(uniques, 0);
  Expect.equals(3, uniques.length);
}
