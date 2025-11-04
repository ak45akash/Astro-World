import 'package:flutter_test/flutter_test.dart';
import 'package:astrology_app/core/services/astrology_service.dart';

void main() {
  group('AstrologyService', () {
    late AstrologyService service;

    setUp(() {
      service = AstrologyService();
    });

    test('should return correct zodiac sign for Aries', () {
      expect(service.getZodiacSign(3, 21), 'Aries');
      expect(service.getZodiacSign(4, 19), 'Aries');
    });

    test('should return correct zodiac sign for Taurus', () {
      expect(service.getZodiacSign(4, 20), 'Taurus');
      expect(service.getZodiacSign(5, 20), 'Taurus');
    });

    test('should return correct zodiac sign for Gemini', () {
      expect(service.getZodiacSign(5, 21), 'Gemini');
      expect(service.getZodiacSign(6, 20), 'Gemini');
    });

    test('should return correct zodiac sign for all signs', () {
      expect(service.getZodiacSign(6, 21), 'Cancer');
      expect(service.getZodiacSign(7, 22), 'Cancer');
      expect(service.getZodiacSign(7, 23), 'Leo');
      expect(service.getZodiacSign(8, 22), 'Leo');
      expect(service.getZodiacSign(8, 23), 'Virgo');
      expect(service.getZodiacSign(9, 22), 'Virgo');
      expect(service.getZodiacSign(9, 23), 'Libra');
      expect(service.getZodiacSign(10, 22), 'Libra');
      expect(service.getZodiacSign(10, 23), 'Scorpio');
      expect(service.getZodiacSign(11, 21), 'Scorpio');
      expect(service.getZodiacSign(11, 22), 'Sagittarius');
      expect(service.getZodiacSign(12, 21), 'Sagittarius');
      expect(service.getZodiacSign(12, 22), 'Capricorn');
      expect(service.getZodiacSign(1, 19), 'Capricorn');
      expect(service.getZodiacSign(1, 20), 'Aquarius');
      expect(service.getZodiacSign(2, 18), 'Aquarius');
      expect(service.getZodiacSign(2, 19), 'Pisces');
    });
  });
}

