import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../../lib/features/horoscope/presentation/widgets/tarot_card_widget.dart';

void main() {
  group('TarotCardWidget', () {
    testWidgets('displays tarot card name and meaning', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TarotCardWidget(
              cardName: 'The Fool',
              meaning: 'New beginnings, innocence, spontaneity',
            ),
          ),
        ),
      );

      expect(find.text('Tarot Card of the Day'), findsOneWidget);
      expect(find.text('The Fool'), findsOneWidget);
      expect(find.text('New beginnings, innocence, spontaneity'), findsOneWidget);
    });

    testWidgets('displays card image when URL is provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TarotCardWidget(
              cardName: 'The Magician',
              meaning: 'Manifestation, resourcefulness, power',
              imageUrl: 'https://example.com/card.jpg',
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('handles missing image gracefully', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TarotCardWidget(
              cardName: 'The High Priestess',
              meaning: 'Intuition, sacred knowledge',
            ),
          ),
        ),
      );

      // Should still display card name and meaning
      expect(find.text('The High Priestess'), findsOneWidget);
      expect(find.text('Intuition, sacred knowledge'), findsOneWidget);
    });
  });
}

