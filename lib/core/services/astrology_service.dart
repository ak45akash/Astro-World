import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';

class AstrologyService {
  final String _apiKey = AppConstants.astrologyApiKey;
  final String _baseUrl = AppConstants.astrologyApiUrl;

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
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/kundli'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'name': name,
          'day': day,
          'month': month,
          'year': year,
          'hour': hour,
          'minute': minute,
          'latitude': latitude,
          'longitude': longitude,
          'timezone': timezone,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to generate Kundli: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error generating Kundli: $e');
    }
  }

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
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/varshphal'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'day': day,
          'month': month,
          'year': year,
          'hour': hour,
          'minute': minute,
          'latitude': latitude,
          'longitude': longitude,
          'timezone': timezone,
          'varshphal_year': varshphalYear,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to generate Varshphal: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error generating Varshphal: $e');
    }
  }

  Future<Map<String, dynamic>> getDailyHoroscope({
    required String zodiacSign,
    required DateTime date,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/horoscope/daily?sign=$zodiacSign&date=${date.toIso8601String()}'),
        headers: {
          'Authorization': 'Bearer $_apiKey',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to fetch horoscope: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching horoscope: $e');
    }
  }

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
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/planets'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'day': day,
          'month': month,
          'year': year,
          'hour': hour,
          'minute': minute,
          'latitude': latitude,
          'longitude': longitude,
          'timezone': timezone,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get planetary positions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error getting planetary positions: $e');
    }
  }

  String getZodiacSign(int month, int day) {
    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return 'Aries';
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return 'Taurus';
    if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) return 'Gemini';
    if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) return 'Cancer';
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return 'Leo';
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return 'Virgo';
    if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) return 'Libra';
    if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) return 'Scorpio';
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return 'Sagittarius';
    if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) return 'Capricorn';
    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return 'Aquarius';
    return 'Pisces';
  }
}

