// Copyright (c) 2020, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'completion_relevance.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(BoolAssignmentTest);
  });
}

@reflectiveTest
class BoolAssignmentTest extends CompletionRelevanceTest {
  @failingTest
  Future<void> test_boolLiterals_imported() async {
    // TODO(brianwilkerson) This test is arguably invalid given that there's no
    //  data to suggest that the boolean keywords should appear before a
    //  constructor in the list, but it does seem likely to be valid in this
    //  case, so we should investigate features that might cause this test to
    //  start passing again.
    await addTestFile('''
foo() {
  bool b;
  b = ^
}
''');

    var trueSuggestion = suggestionWith(
        completion: 'true', kind: CompletionSuggestionKind.KEYWORD);

    var falseSuggestion = suggestionWith(
        completion: 'false', kind: CompletionSuggestionKind.KEYWORD);

    var boolFromEnvironment = suggestionWith(
        completion: 'bool.fromEnvironment',
        element: ElementKind.CONSTRUCTOR,
        kind: CompletionSuggestionKind.INVOCATION);

    assertOrder([trueSuggestion, falseSuggestion, boolFromEnvironment]);
  }

  Future<void> test_boolLiterals_local() async {
    await addTestFile('''
foo() {
  bool b;
  b = ^
}
''');

    var trueSuggestion = suggestionWith(
        completion: 'true', kind: CompletionSuggestionKind.KEYWORD);

    var falseSuggestion = suggestionWith(
        completion: 'false', kind: CompletionSuggestionKind.KEYWORD);

    var bLocalVar = suggestionWith(
        completion: 'b',
        element: ElementKind.LOCAL_VARIABLE,
        kind: CompletionSuggestionKind.INVOCATION);

    assertOrder([bLocalVar, trueSuggestion, falseSuggestion]);
  }
}
