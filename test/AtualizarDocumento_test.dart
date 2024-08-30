// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/i_am_logged_in.dart';
import './step/i_have_a_document_named_already_stored.dart';
import './step/i_select_the_from_my_list_of_stored_documents.dart';
import './step/i_tap_the_button.dart';
import './step/i_update_the_document_using_the_or_option.dart';
import './step/i_enter_into_the_input_field.dart';
import './step/i_should_see_a_confirmation_message.dart';
import './step/i_should_see_the_document_named_in_my_list_of_stored_documents.dart';
import './step/the_old_document_named_should_no_longer_appear_in_my_list_of_stored_documents.dart';
import './step/i_have_another_document_named_already_stored.dart';
import './step/i_should_see_a_warning_message.dart';
import './step/i_should_return_to_the_editting_section.dart';

void main() {
  group('''Update Documents''', () {
    testWidgets('''Replacing an old document with a new one''', (tester) async {
      await iAmLoggedIn(tester);
      await iHaveADocumentNamedAlreadyStored(tester, 'Document');
      await iSelectTheFromMyListOfStoredDocuments(tester, 'Document');
      await iTapTheButton(tester, edit);
      await iUpdateTheDocumentUsingTheOrOption(tester, 'camera', 'gallery');
      await iEnterIntoTheInputField(
          tester, 'Updated Document', 'Document Name');
      await iTapTheButton(tester, replace);
      await iShouldSeeAConfirmationMessage(
          tester, 'Document replaced successfully');
      await iShouldSeeTheDocumentNamedInMyListOfStoredDocuments(
          tester, 'Updated Document');
      await theOldDocumentNamedShouldNoLongerAppearInMyListOfStoredDocuments(
          tester, 'Document');
    });
    testWidgets(
        '''Replacing an old document with a new one with a name that already exists''',
        (tester) async {
      await iAmLoggedIn(tester);
      await iHaveADocumentNamedAlreadyStored(tester, 'Document');
      await iHaveAnotherDocumentNamedAlreadyStored(tester, 'Updated Document');
      await iSelectTheFromMyListOfStoredDocuments(tester, 'Document');
      await iTapTheButton(tester, edit);
      await iUpdateTheDocumentUsingTheOrOption(tester, 'camera', 'gallery');
      await iEnterIntoTheInputField(
          tester, 'Updated Document', 'Document Name');
      await iTapTheButton(tester, replace);
      await iShouldSeeAWarningMessage(
          tester, 'A document with this name already exists.');
      await iShouldReturnToTheEdittingSection(tester);
    });
  });
}
