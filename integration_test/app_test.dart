import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:integration_test/integration_test.dart';
import 'package:cicd_tutorial/main.dart' as app;

// Dev mode command: flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d chrome --no-headless

const String password = '123456';
const String email = 'noland@advancedwebapps.ca';

void main() {
  final IntegrationTestWidgetsFlutterBinding binding = IntegrationTestWidgetsFlutterBinding();
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('increment, auth, and posts', (WidgetTester tester) async {
      app.main();
      // Wait for Firebase services to connect etc.
      await tester.pump(const Duration(milliseconds: 5000));
      await tester.pumpAndSettle();

      // Verify the counter starts at 0.
      expect(find.text('0'), findsOneWidget);
      // Take screenshot
      await binding.takeScreenshot('pre-increment');

      // Finds the floating action button to tap on.
      final Finder fab = find.byTooltip('Increment');

      // Emulate a tap on the floating action button.
      await tester.tap(fab);

      // Trigger a frame.l
      await tester.pumpAndSettle();

      // Verify the counter increments by 1.
      expect(find.text('1'), findsOneWidget);
      // Take screenshot
      await binding.takeScreenshot('post-increment');

      // Ensure we can't see posts
      expect(find.text('The First Post'), findsNothing);

      // Authenticate
      // Enter creds
      await tester.enterText(find.byType(EmailInput), email);
      await tester.enterText(find.byType(PasswordInput), password);
      await tester.pumpAndSettle();
      // Tap button
      await tester.tap(find.text('Sign in').at(1)); // Very brittle. Need a better way to find the Sign In button
      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 5000)); // it can take a while to finish auth flow and fetch firestore docs etc.
      await tester.pumpAndSettle();

      // Verify we authenticated
      final Finder userEmail = find.byKey(const Key('auth:user-email'));
      expect(userEmail, findsWidgets);
      expect((userEmail.evaluate().single.widget as Text).data, email);

      // Ensure we can now see posts
      expect(find.text('The First Post'), findsOneWidget);

      await tester.pumpAndSettle();
      await tester.pump(const Duration(milliseconds: 5000));
    });
  });
}
