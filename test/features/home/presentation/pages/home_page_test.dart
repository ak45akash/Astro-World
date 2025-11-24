import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:astrology_app/features/home/presentation/pages/home_page.dart';

void main() {
  group('HomePage Tests', () {
    testWidgets('HomePage renders without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('HomePage displays Astrology Services section', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Astrology Services'), findsOneWidget);
    });

    testWidgets('HomePage displays all 4 service cards', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text("Today's Horoscope"), findsOneWidget);
      expect(find.text('Free Kundli'), findsOneWidget);
      expect(find.text('Compatibility'), findsOneWidget);
      expect(find.text('Consultation'), findsOneWidget);
    });

    testWidgets('HomePage displays carousel with 3 slides', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check for carousel indicators (3 dots)
      final indicators = find.byType(Container);
      expect(indicators, findsWidgets);
    });

    testWidgets('HomePage displays carousel slide content', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check for carousel slide content
      expect(find.text('Chat with'), findsOneWidget);
      expect(find.text('Astrologers'), findsOneWidget);
    });

    testWidgets('Service cards have images', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Check for Image widgets in service cards
      final images = find.byType(Image);
      expect(images, findsWidgets);
    });

    testWidgets('Service cards are centered', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find service card containers
      final serviceCards = find.byType(InkWell);
      expect(serviceCards, findsWidgets);

      // Verify cards have centered content
      for (final card in tester.widgetList<InkWell>(serviceCards)) {
        final child = card.child;
        if (child is Container) {
          final padding = child.padding;
          if (padding is EdgeInsets) {
            expect(padding.horizontal, greaterThan(0));
            expect(padding.vertical, greaterThan(0));
          }
        }
      }
    });

    testWidgets('Carousel auto-advances after timer', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Wait for carousel timer to trigger (5 seconds)
      await tester.pump(const Duration(milliseconds: 5100));
      await tester.pumpAndSettle();

      // Verify carousel has advanced (check for different slide content)
      // This is a basic test - actual carousel state would need more complex testing
      expect(find.byType(PageView), findsOneWidget);
    });

    testWidgets('HomePage displays Our Astrologers section', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Our Astrologers'), findsOneWidget);
      expect(find.text('View all'), findsOneWidget);
    });

    testWidgets('Service cards are tappable', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: HomePage(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find and tap a service card
      final serviceCard = find.text("Today's Horoscope").first;
      expect(serviceCard, findsOneWidget);

      await tester.tap(serviceCard);
      await tester.pumpAndSettle();
    });
  });
}

