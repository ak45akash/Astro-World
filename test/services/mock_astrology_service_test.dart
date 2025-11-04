import 'package:flutter_test/flutter_test.dart';
import 'package:astrology_app/core/services/mock_astrology_service.dart';
import 'package:astrology_app/core/config/test_constants.dart';
import '../helpers/test_setup.dart';

void main() {
  late MockAstrologyService service;

  setUp(() {
    setupTestEnvironment();
    service = MockAstrologyService();
  });

  tearDown(() {
    teardownTestEnvironment();
  });

  group('MockAstrologyService', () {
    test('should generate mock Kundli', () async {
      final result = await service.generateKundli(
        name: TestConstants.testUserName,
        day: 15,
        month: 6,
        year: 1990,
        hour: 10,
        minute: 30,
        latitude: 28.6139,
        longitude: 77.2090,
        timezone: 'Asia/Kolkata',
      );

      expect(result['success'], true);
      expect(result['data'], isNotNull);
    });

    test('should generate mock Varshphal', () async {
      final result = await service.generateVarshphal(
        day: 15,
        month: 6,
        year: 1990,
        hour: 10,
        minute: 30,
        latitude: 28.6139,
        longitude: 77.2090,
        timezone: 'Asia/Kolkata',
        varshphalYear: DateTime.now().year,
      );

      expect(result['success'], true);
      expect(result['data'], isNotNull);
    });

    test('should get mock daily horoscope', () async {
      final result = await service.getDailyHoroscope(
        zodiacSign: TestConstants.testZodiacSign,
        date: DateTime.now(),
      );

      expect(result['success'], true);
      expect(result['data'], isNotNull);
      expect(result['data']['prediction'], isNotEmpty);
    });

    test('should get mock planetary positions', () async {
      final result = await service.getPlanetaryPositions(
        day: 15,
        month: 6,
        year: 1990,
        hour: 10,
        minute: 30,
        latitude: 28.6139,
        longitude: 77.2090,
        timezone: 'Asia/Kolkata',
      );

      expect(result['success'], true);
      expect(result['data'], isNotNull);
      expect(result['data']['planets'], isList);
    });

    test('should calculate zodiac sign correctly', () {
      expect(service.getZodiacSign(3, 21), 'Aries');
      expect(service.getZodiacSign(4, 20), 'Taurus');
      expect(service.getZodiacSign(5, 21), 'Gemini');
      expect(service.getZodiacSign(6, 21), 'Cancer');
    });
  });
}

