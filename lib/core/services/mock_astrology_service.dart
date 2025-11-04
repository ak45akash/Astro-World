import 'dart:async';
import 'astrology_service.dart';
import '../config/test_constants.dart';

/// Mock implementation of AstrologyService for testing
class MockAstrologyService extends AstrologyService {
  // Simulate network delay
  final Duration _delay = const Duration(milliseconds: 500);

  @override
  Future<Map<String, dynamic>> generateKundli({
    required String name,
    required int day,
    required int month,
    required int year,
    required int hour,
    required int minute,
    required double latitude,
    required double longitude,
    required String timezone,
  }) async {
    await Future.delayed(_delay);
    return TestConstants.mockKundliResponse;
  }

  @override
  Future<Map<String, dynamic>> generateVarshphal({
    required int day,
    required int month,
    required int year,
    required int hour,
    required int minute,
    required double latitude,
    required double longitude,
    required String timezone,
    required int varshphalYear,
  }) async {
    await Future.delayed(_delay);
    return TestConstants.mockVarshphalResponse;
  }

  @override
  Future<Map<String, dynamic>> getDailyHoroscope({
    required String zodiacSign,
    required DateTime date,
  }) async {
    await Future.delayed(_delay);
    return {
      'success': true,
      'data': TestConstants.testHoroscopeData,
    };
  }

  @override
  Future<Map<String, dynamic>> getPlanetaryPositions({
    required int day,
    required int month,
    required int year,
    required int hour,
    required int minute,
    required double latitude,
    required double longitude,
    required String timezone,
  }) async {
    await Future.delayed(_delay);
    return {
      'success': true,
      'data': {
        'planets': [
          {'name': 'Sun', 'position': '10° Aries'},
          {'name': 'Moon', 'position': '15° Gemini'},
        ],
      },
    };
  }

  @override
  String getZodiacSign(int month, int day) {
    // Use actual implementation for testing
    return super.getZodiacSign(month, day);
  }
}

