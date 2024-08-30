// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/i_am_logged_in.dart';
import './step/i_tap_the_icon.dart';
import './step/i_capture_a_new_photo.dart';
import './step/i_see_a_text_field_labeled.dart';
import './step/i_enter_into_the_input_field.dart';
import './step/i_tap_the_button_to_add_the_document_to_my_storage.dart';
import './step/i_should_see_a_confirmation_message.dart';
import './step/i_should_see_the_document_named_in_my_list_of_stored_documents.dart';
import './step/i_select_an_image_named.dart';
import './step/i_leave_the_input_field_empty.dart';
import './step/i_should_see_an_error_message.dart';
import './step/the_document_should_not_be_added_to_my_list_of_stored_documents.dart';

void main() {
  group('''Add Documents''', () {
    testWidgets('''Adding a new document via camera''', (tester) async {
      await iAmLoggedIn(tester);
      await iTapTheIcon(tester, camera);
      await iCaptureANewPhoto(tester);
      await iSeeATextFieldLabeled(tester, 'Document Name');
      await iEnterIntoTheInputField(tester, 'Name', 'Document Name');
      await iTapTheButtonToAddTheDocumentToMyStorage(tester, save);
      await iShouldSeeAConfirmationMessage(
          tester, 'Document added successfully');
      await iShouldSeeTheDocumentNamedInMyListOfStoredDocuments(tester, 'Name');
    });
    testWidgets('''Adding a new document from the gallery''', (tester) async {
      await iAmLoggedIn(tester);
      await iTapTheIcon(tester, gallery);
      await iSelectAnImageNamed(tester, 'Document.jpg');
      await iSeeATextFieldLabeled(tester, 'Document Name');
      await iEnterIntoTheInputField(tester, 'Name', 'Document Name');
      await iTapTheButtonToAddTheDocumentToMyStorage(tester, save);
      await iShouldSeeAConfirmationMessage(
          tester, 'Document added successfully');
      await iShouldSeeTheDocumentNamedInMyListOfStoredDocuments(tester, 'Name');
    });
    testWidgets('''Adding a document without providing a name''',
        (tester) async {
      await iAmLoggedIn(tester);
      await iTapTheIcon(tester, camera);
      await iCaptureANewPhoto(tester);
      await iSeeATextFieldLabeled(tester, 'Document Name');
      await iLeaveTheInputFieldEmpty(tester, 'Document Name');
      await iTapTheButtonToAddTheDocumentToMyStorage(tester, save);
      await iShouldSeeAnErrorMessage(tester, 'Document name is required');
      await theDocumentShouldNotBeAddedToMyListOfStoredDocuments(tester);
    });
  });
}
