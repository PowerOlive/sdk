// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
// Dart test checking that static/instance field shadowing do not conflict.

// @dart = 2.9

class A {
  int instanceFieldInA;
  static int staticFieldInA;
}

class B extends A {
  static int instanceFieldInA; //  //# 01: compile-time error
  int staticFieldInA; //           //# 02: ok
  static int staticFieldInA; //    //# 03: ok
}

main() {
  var x = new B();
}
