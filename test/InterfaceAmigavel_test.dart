// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/that_i_am_logged_in.dart';
import './step/i_browse_the_app.dart';
import './step/i_should_be_able_to_access_add_edit_and_delete_documents_easily_without_confusion.dart';

void main() {
  group('''User-friendly Interface''', () {
    testWidgets('''Easy navigation and document management''', (tester) async {
      await thatIAmLoggedIn(tester);
      await iBrowseTheApp(tester);
      await iShouldBeAbleToAccessAddEditAndDeleteDocumentsEasilyWithoutConfusion(
          tester);
    });
  });
}
