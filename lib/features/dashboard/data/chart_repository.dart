import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/chart_models.dart';

class ChartRepository {
  static const _cachePrefix = 'chart_bundle_';
  final Future<SharedPreferences> Function() _prefsBuilder;

  ChartRepository({
    Future<SharedPreferences> Function()? prefsBuilder,
  }) : _prefsBuilder = prefsBuilder ?? SharedPreferences.getInstance;

  Future<ChartBundle> loadChartsForUser(String userId) async {
    final prefs = await _prefsBuilder();
    final cacheKey = '$_cachePrefix$userId';
    final now = DateTime.now();
    final cached = prefs.getString(cacheKey);

    if (cached != null) {
      try {
        final json = jsonDecode(cached) as Map<String, dynamic>;
        final bundle = ChartBundle.fromJson(json);
        if (bundle.nextRefreshAt.isAfter(now)) {
          return bundle;
        }
      } catch (_) {
        // fallthrough to refresh if cache is corrupted
      }
    }

    final fresh = await _generateSampleBundle(now);
    await prefs.setString(cacheKey, jsonEncode(fresh.toJson()));
    return fresh;
  }

  Future<void> clearCache(String userId) async {
    final prefs = await _prefsBuilder();
    await prefs.remove('$_cachePrefix$userId');
  }

  Future<ChartBundle> _generateSampleBundle(DateTime now) async {
    final currentYear = now.year;
    final birthday = DateTime(currentYear, now.month, now.day);
    final nextBirthday = DateTime(currentYear + 1, now.month, now.day);

    final varshfalStart = birthday.isBefore(now)
        ? birthday
        : birthday.subtract(const Duration(days: 365));
    final varshfalEnd = varshfalStart.add(const Duration(days: 365));

    final varshfal = [
      VarshfalPeriod(
        title: 'Solar Return Focus',
        startDate: varshfalStart,
        endDate: varshfalEnd,
        focus: 'Strengthen personal leadership and financial discipline.',
      ),
      VarshfalPeriod(
        title: 'Growth Opportunity',
        startDate: varshfalStart.add(const Duration(days: 90)),
        endDate: varshfalStart.add(const Duration(days: 180)),
        focus: 'Collaborations and partnerships flourish.',
      ),
    ];

    final planetaryPositions = [
      const PlanetPosition(
        planet: 'Sun',
        degree: 120.5,
        nakshatra: 'Purva Phalguni',
        pada: 'Pada 3',
      ),
      const PlanetPosition(
        planet: 'Moon',
        degree: 45.2,
        nakshatra: 'Rohini',
        pada: 'Pada 1',
      ),
      const PlanetPosition(
        planet: 'Mars',
        degree: 200.8,
        nakshatra: 'Shatabhisha',
        pada: 'Pada 2',
      ),
      const PlanetPosition(
        planet: 'Venus',
        degree: 15.4,
        nakshatra: 'Ashwini',
        pada: 'Pada 4',
      ),
    ];

    final dashaTimeline = [
      DashaPeriod(
        name: 'Jupiter Mahadasha',
        startDate: DateTime(currentYear - 2, 8, 14),
        endDate: DateTime(currentYear + 15, 8, 14),
        ruler: 'Jupiter',
      ),
      DashaPeriod(
        name: 'Saturn Antardasha',
        startDate: now.subtract(const Duration(days: 180)),
        endDate: now.add(const Duration(days: 540)),
        ruler: 'Saturn',
      ),
      DashaPeriod(
        name: 'Mercury Antardasha',
        startDate: now.add(const Duration(days: 540)),
        endDate: now.add(const Duration(days: 900)),
        ruler: 'Mercury',
      ),
    ];

    return ChartBundle(
      generatedAt: now,
      nextRefreshAt: nextBirthday,
      varshfal: varshfal,
      planetaryPositions: planetaryPositions,
      dashaTimeline: dashaTimeline,
      lagna: 'Leo Lagna',
      navamsha: 'Gemini Navamsha',
      moonSign: 'Taurus Moon',
      chalitSummary: const [
        '1st House: Leo - Leadership focus, Sun influence strong.',
        '4th House: Scorpio - Emotional transformation at home.',
        '7th House: Aquarius - Partnerships demand innovation.',
        '10th House: Taurus - Career stability through persistence.',
      ],
    );
  }
}
