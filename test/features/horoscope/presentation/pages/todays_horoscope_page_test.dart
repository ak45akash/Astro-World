import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../lib/features/horoscope/presentation/pages/todays_horoscope_page.dart';

void main() {
  group('TodaysHoroscopePage', () {
    testWidgets('displays loading indicator when loading', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              routes: [
                GoRoute(
                  path: '/horoscope',
                  builder: (context, state) => const TodaysHoroscopePage(),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pump();
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('displays error message when horoscope fails to load', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              routes: [
                GoRoute(
                  path: '/horoscope',
                  builder: (context, state) => const TodaysHoroscopePage(),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      // Error state should show retry button
      expect(find.text('Retry'), findsOneWidget);
    });

    testWidgets('displays zodiac carousel', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              routes: [
                GoRoute(
                  path: '/horoscope',
                  builder: (context, state) => const TodaysHoroscopePage(),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Aries'), findsWidgets);
      expect(find.text('Taurus'), findsWidgets);
    });

    testWidgets('displays header with title and date', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              routes: [
                GoRoute(
                  path: '/horoscope',
                  builder: (context, state) => const TodaysHoroscopePage(),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text("Today's Horoscope"), findsOneWidget);
    });

    testWidgets('displays bookmark and share buttons', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              routes: [
                GoRoute(
                  path: '/horoscope',
                  builder: (context, state) => const TodaysHoroscopePage(),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.bookmark_border), findsOneWidget);
      expect(find.byIcon(Icons.share), findsOneWidget);
    });

    testWidgets('displays navigation buttons for yesterday, today, tomorrow', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              routes: [
                GoRoute(
                  path: '/horoscope',
                  builder: (context, state) => const TodaysHoroscopePage(),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Yesterday'), findsOneWidget);
      expect(find.text('Today'), findsOneWidget);
      expect(find.text('Tomorrow'), findsOneWidget);
    });

    testWidgets('displays CTA section with action buttons', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              routes: [
                GoRoute(
                  path: '/horoscope',
                  builder: (context, state) => const TodaysHoroscopePage(),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Ask AI (Free Questions)'), findsOneWidget);
      expect(find.text('Talk to Astrologer Now'), findsOneWidget);
      expect(find.text('Match Compatibility'), findsOneWidget);
    });

    testWidgets('can toggle bookmark', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: GoRouter(
              routes: [
                GoRoute(
                  path: '/horoscope',
                  builder: (context, state) => const TodaysHoroscopePage(),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      final bookmarkButton = find.byIcon(Icons.bookmark_border);
      expect(bookmarkButton, findsOneWidget);
      
      await tester.tap(bookmarkButton);
      await tester.pump();
      
      // Bookmark icon should change
      expect(find.byIcon(Icons.bookmark), findsOneWidget);
    });
  });
}

