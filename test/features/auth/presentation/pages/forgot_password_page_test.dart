import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:astrology_app/features/auth/presentation/pages/forgot_password_page.dart';

void main() {
  group('ForgotPasswordPage', () {
    testWidgets('displays forgot password form correctly', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ForgotPasswordPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check for header
      expect(find.text('Astrotalk'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);

      // Check for form
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('Send Reset Link'), findsOneWidget);
      expect(find.text('Back to Sign In'), findsOneWidget);
    });

    testWidgets('validates email field', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ForgotPasswordPage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Try to submit without email
      await tester.tap(find.text('Send Reset Link'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your email'), findsOneWidget);
    });
  });
}

