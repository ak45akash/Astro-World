import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../lib/core/services/horoscope_service.dart';
import '../../../lib/models/horoscope_model.dart';

void main() {
  group('HoroscopeService', () {
    late HoroscopeService service;

    setUp(() {
      service = HoroscopeService();
    });

    test('getDailyHoroscope returns null when not found in Firestore', () async {
      // This test would require Firebase emulator setup
      // For now, we test the structure
      final result = await service.getDailyHoroscope(
        zodiacSign: 'Aries',
        date: DateTime.now(),
      );

      // Since we removed API fallback, it should return null if not in Firestore
      // This is expected behavior - Cloud Function populates Firestore
      expect(result, isNull);
    });

    test('getAllDailyHoroscopes returns list', () async {
      final result = await service.getAllDailyHoroscopes(DateTime.now());
      expect(result, isA<List<HoroscopeModel>>());
    });

    test('getHoroscopesStream returns stream', () {
      final stream = service.getHoroscopesStream(DateTime.now());
      expect(stream, isA<Stream<List<HoroscopeModel>>>());
    });
  });
}

