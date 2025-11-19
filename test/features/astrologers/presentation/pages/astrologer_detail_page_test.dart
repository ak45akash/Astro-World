import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:astrology_app/features/astrologers/presentation/pages/astrologer_detail_page.dart';
import 'package:astrology_app/core/router/app_router.dart';

void main() {
  group('AstrologerDetailPage', () {
    testWidgets('displays astrologer information correctly', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: routerProvider,
          ),
        ),
      );

      // Navigate to astrologer detail page
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: const AstrologerDetailPage(astrologerId: '1'),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check for back button
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);

      // Check for header with Astrotalk
      expect(find.text('Astrotalk'), findsOneWidget);
    });

    testWidgets('back button navigates correctly', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Builder(
              builder: (context) => Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AstrologerDetailPage(astrologerId: '1'),
                        ),
                      );
                    },
                    child: const Text('Navigate'),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Navigate'));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.text('Navigate'), findsOneWidget);
    });
  });
}

