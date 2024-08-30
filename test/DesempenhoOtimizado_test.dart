// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/that_i_have_a_stable_internet_connection.dart';
import './step/i_add_edit_or_delete_documents.dart';
import './step/the_application_should_perform_these_actions_without_slowdowns_or_errors.dart';

void main() {
  group('''Optimized Performance''', () {
    testWidgets('''Smooth operation when storing documents''', (tester) async {
      await thatIHaveAStableInternetConnection(tester);
      await iAddEditOrDeleteDocuments(tester);
      await theApplicationShouldPerformTheseActionsWithoutSlowdownsOrErrors(
          tester);
    });
  });
}
