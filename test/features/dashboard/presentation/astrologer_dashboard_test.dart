import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:astrology_app/core/providers/auth_provider.dart';
import 'package:astrology_app/features/dashboard/domain/models/chart_models.dart';
import 'package:astrology_app/features/dashboard/presentation/pages/astrologer_dashboard.dart';
import 'package:astrology_app/features/dashboard/presentation/providers/chart_providers.dart';
import 'package:astrology_app/models/user_model.dart';

void main() {
  final now = DateTime(2025, 1, 1);
  final sampleBundle = ChartBundle(
    generatedAt: now,
    nextRefreshAt: now.add(const Duration(days: 365)),
    varshfal: [
      VarshfalPeriod(
        title: 'Sample Period',
        startDate: now.subtract(const Duration(days: 30)),
        endDate: now.add(const Duration(days: 335)),
        focus: 'Focus on growth.',
      ),
    ],
    planetaryPositions: const [
      PlanetPosition(
        planet: 'Sun',
        degree: 120,
        nakshatra: 'Rohini',
        pada: 'Pada 2',
      ),
    ],
    dashaTimeline: [
      DashaPeriod(
        name: 'Jupiter Mahadasha',
        startDate: now.subtract(const Duration(days: 100)),
        endDate: now.add(const Duration(days: 120)),
        ruler: 'Jupiter',
      ),
    ],
    lagna: 'Leo Lagna',
    navamsha: 'Gemini Navamsha',
    moonSign: 'Taurus Moon',
    chalitSummary: const [
      '1st House: Leo - Leadership qualities strong.',
    ],
  );

  final sampleUser = UserModel(
    id: 'demo',
    email: 'demo@astrology.app',
    displayName: 'Demo User',
    role: 'super_admin',
    createdAt: now,
  );

  testWidgets('Astrologer dashboard shows chart sections', (tester) async {
    final view = tester.view;
    view.physicalSize = const Size(1200, 2200);
    view.devicePixelRatio = 1.0;
    addTearDown(() {
      view.resetPhysicalSize();
      view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          chartBundleProvider.overrideWith((ref) async => sampleBundle),
          authStateProvider.overrideWith(
            (ref) => Stream.value(sampleUser),
          ),
        ],
        child: const MaterialApp(
          home: AstrologerDashboard(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Varshfal Cycle'), findsOneWidget);
    expect(find.text('Current Dasha'), findsOneWidget);
    expect(find.text('Core Charts'), findsOneWidget);
  });
}
