import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:astrology_app/features/dashboard/data/chart_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ChartRepository', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('returns cached bundle while refresh window is active', () async {
      final repository = ChartRepository();

      final first = await repository.loadChartsForUser('user-1');
      await Future<void>.delayed(const Duration(milliseconds: 10));
      final second = await repository.loadChartsForUser('user-1');

      expect(second.generatedAt, equals(first.generatedAt));
      expect(second.nextRefreshAt, equals(first.nextRefreshAt));
    });

    test('refreshes bundle when cache has expired', () async {
      final repository = ChartRepository();
      final prefs = await SharedPreferences.getInstance();

      final initial = await repository.loadChartsForUser('user-2');
      final expired = Map<String, dynamic>.from(initial.toJson())
        ..['nextRefreshAt'] =
            DateTime.now().subtract(const Duration(days: 1)).toIso8601String();

      await prefs.setString(
        'chart_bundle_user-2',
        jsonEncode(expired),
      );

      await Future<void>.delayed(const Duration(milliseconds: 10));
      final refreshed = await repository.loadChartsForUser('user-2');

      expect(refreshed.generatedAt.isAfter(initial.generatedAt), isTrue);
    });
  });
}
