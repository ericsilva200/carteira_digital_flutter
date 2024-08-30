// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/i_am_logged_in.dart';
import './step/i_have_a_document_named_already_stored.dart';
import './step/i_tap_on_the_document_named_in_my_list_of_stored_documents.dart';
import './step/i_should_see_the_document_displayed_in_a_readable_way.dart';
import './step/i_should_see_a_toolbar_with_options.dart';
import './step/i_should_see_the_document_name_and_the_creation_date_displayed.dart';
import './step/i_tap_the_button_on_the_toolbar.dart';
import './step/i_should_be_returned_to_the_list_of_stored_documents.dart';

void main() {
  group('''View Documents''', () {
    testWidgets('''Viewing a document''', (tester) async {
      await iAmLoggedIn(tester);
      await iHaveADocumentNamedAlreadyStored(tester, 'Name');
      await iTapOnTheDocumentNamedInMyListOfStoredDocuments(tester, 'Name');
      await iShouldSeeTheDocumentDisplayedInAReadableWay(tester, 'Name');
      await iShouldSeeAToolbarWithOptions(tester, 'Edit', 'Delete');
      await iShouldSeeTheDocumentNameAndTheCreationDateDisplayed(
          tester, 'Name');
      await iTapTheButtonOnTheToolbar(tester, back);
      await iShouldBeReturnedToTheListOfStoredDocuments(tester);
    });
  });
}
