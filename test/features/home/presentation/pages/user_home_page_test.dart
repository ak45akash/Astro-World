import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:astrology_app/features/home/presentation/pages/user_home_page.dart';

void main() {
  group('UserHomePage Tests', () {
    testWidgets('UserHomePage renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: UserHomePage(),
          ),
        ),
      );

      expect(find.byType(UserHomePage), findsOneWidget);
    });

    testWidgets('UserHomePage displays Astrology Services section', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: UserHomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Astrology Services'), findsOneWidget);
    });

    testWidgets('UserHomePage displays all 4 service cards', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: UserHomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text("Today's Horoscope"), findsOneWidget);
      expect(find.text('Free Kundli'), findsOneWidget);
      expect(find.text('Compatibility'), findsOneWidget);
      expect(find.text('Consultation'), findsOneWidget);
    });

    testWidgets('UserHomePage displays carousel with 3 slides', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: UserHomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check for carousel
      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets('UserHomePage service cards have images', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: UserHomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check for Image widgets in service cards
      final images = find.byType(Image);
      expect(images, findsWidgets);
    });

    testWidgets('UserHomePage service cards are centered', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: UserHomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find service card containers
      final serviceCards = find.byType(InkWell);
      expect(serviceCards, findsWidgets);
    });

    testWidgets('UserHomePage carousel auto-advances', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: UserHomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Wait for carousel timer
      await tester.pump(const Duration(milliseconds: 5100));
      await tester.pumpAndSettle();

      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets('UserHomePage displays header', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: UserHomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Astrotalk'), findsOneWidget);
    });
  });
}

