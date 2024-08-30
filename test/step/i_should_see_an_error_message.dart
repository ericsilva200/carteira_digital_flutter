import 'package:flutter_test/flutter_test.dart';

/// Usage: I should see an error message {'Document name is required'}
Future<void> iShouldSeeAnErrorMessage(
    WidgetTester tester, String param1) async {
  throw UnimplementedError();
}
