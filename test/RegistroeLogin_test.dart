// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/i_am_on_the_registration_screen.dart';
import './step/i_enter_valid_data.dart';
import './step/i_tap_the_button.dart';
import './step/i_should_see_a_confirmation_message.dart';
import './step/i_should_be_redirected_to_the_login_screen.dart';
import './step/i_enter_registration_data.dart';
import './step/the_username_pedro_is_already_registered.dart';
import './step/i_should_see_an_error_message.dart';
import './step/i_should_remain_on_the_registration_screen.dart';
import './step/i_am_on_the_login_screen.dart';
import './step/i_enter_login_credentials.dart';
import './step/i_should_be_logged_in_successfully.dart';
import './step/i_should_remain_on_the_login_screen.dart';

void main() {
  group('''User Registration and Login''', () {
    testWidgets('''User registration with valid data''', (tester) async {
      await iAmOnTheRegistrationScreen(tester);
      await iEnterValidData(
          tester,
          const bdd.DataTable([
            [UserName, Pedro],
            [Password, Password123]
          ]));
      await iTapTheButton(tester, submit);
      await iShouldSeeAConfirmationMessage(tester, 'Registration successful!');
      await iShouldBeRedirectedToTheLoginScreen(tester);
    });
    testWidgets('''User registration with an User Name''', (tester) async {
      await iAmOnTheRegistrationScreen(tester);
      await iEnterRegistrationData(
          tester,
          const bdd.DataTable([
            [UserName, Pedro],
            [Password, Password123]
          ]));
      await theUsernamePedroIsAlreadyRegistered(tester);
      await iTapTheButton(tester, submit);
      await iShouldSeeAnErrorMessage(tester, 'User Name already registered');
      await iShouldRemainOnTheRegistrationScreen(tester);
    });
    testWidgets('''User login with correct credentials''', (tester) async {
      await iAmOnTheLoginScreen(tester);
      await iEnterLoginCredentials(
          tester,
          const bdd.DataTable([
            [UserName, Pedro],
            [Password, Password123]
          ]));
      await iTapTheButton(tester, login);
      await iShouldBeLoggedInSuccessfully(tester);
    });
    testWidgets('''User login with incorrect credentials''', (tester) async {
      await iAmOnTheLoginScreen(tester);
      await iEnterLoginCredentials(
          tester,
          const bdd.DataTable([
            [UserName, Pedro],
            [Password, Password123]
          ]));
      await iTapTheButton(tester, login);
      await iShouldSeeAnErrorMessage(tester, 'Invalid email or password');
      await iShouldRemainOnTheLoginScreen(tester);
    });
  });
}
