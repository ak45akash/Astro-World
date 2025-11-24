import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../../lib/features/horoscope/presentation/widgets/energy_meter_widget.dart';

void main() {
  group('EnergyMeterWidget', () {
    testWidgets('displays all three energy periods', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EnergyMeterWidget(
              morning: 7,
              afternoon: 5,
              evening: 8,
            ),
          ),
        ),
      );

      expect(find.text('Morning'), findsOneWidget);
      expect(find.text('Afternoon'), findsOneWidget);
      expect(find.text('Evening'), findsOneWidget);
    });

    testWidgets('displays correct energy values', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EnergyMeterWidget(
              morning: 7,
              afternoon: 5,
              evening: 8,
            ),
          ),
        ),
      );

      expect(find.text('7/10'), findsOneWidget);
      expect(find.text('5/10'), findsOneWidget);
      expect(find.text('8/10'), findsOneWidget);
    });

    testWidgets('displays progress bars', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EnergyMeterWidget(
              morning: 7,
              afternoon: 5,
              evening: 8,
            ),
          ),
        ),
      );

      expect(find.byType(LinearProgressIndicator), findsNWidgets(3));
    });

    testWidgets('displays energy meter title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EnergyMeterWidget(
              morning: 7,
              afternoon: 5,
              evening: 8,
            ),
          ),
        ),
      );

      expect(find.text('Energy Meter'), findsOneWidget);
    });
  });
}

