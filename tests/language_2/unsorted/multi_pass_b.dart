// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// Dart test for loading several dart files and resolving superclasses lazily.

// @dart = 2.9

part of MultiPassTest.dart;

class B extends A {
  B(v) : super(v) {}
}
