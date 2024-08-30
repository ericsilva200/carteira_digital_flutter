// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/i_am_logged_in.dart';
import './step/i_have_a_document_named_stored.dart';
import './step/i_select_the_from_my_list_of_stored_documents.dart';
import './step/i_tap_the_icon.dart';
import './step/i_should_see_a_confirmation_dialog_with_the_message.dart';
import './step/i_tap_the_button_on_the_confirmation_dialog.dart';
import './step/i_should_see_a_confirmation_message.dart';
import './step/the_document_named_should_no_longer_appear_in_my_list_of_stored_documents.dart';

void main() {
  group('''Delete Documents''', () {
    testWidgets('''Deleting a document from storage''', (tester) async {
      await iAmLoggedIn(tester);
      await iHaveADocumentNamedStored(tester, 'Name');
      await iSelectTheFromMyListOfStoredDocuments(tester, 'Name');
      await iTapTheIcon(tester, delete);
      await iShouldSeeAConfirmationDialogWithTheMessage(
          tester, 'Are you sure you want to delete this document?');
      await iTapTheButtonOnTheConfirmationDialog(tester, confirm);
      await iShouldSeeAConfirmationMessage(
          tester, 'Document deleted successfully');
      await theDocumentNamedShouldNoLongerAppearInMyListOfStoredDocuments(
          tester, 'Name');
    });
  });
}
