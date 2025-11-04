import 'app_constants.dart';

class TestConstants {
  // Test API Keys (use environment variables in production)
  static const String testRazorpayKeyId = 'rzp_test_1234567890';
  static const String testAgoraAppId = 'test_agora_app_id';
  static const String testAstrologyApiKey = 'test_astrology_api_key';
  static const String testAstrologyApiUrl = 'https://api.test.vedicrishiastro.com/v1';

  // Test User Data
  static const String testUserId = 'test_user_123';
  static const String testUserEmail = 'test@example.com';
  static const String testUserPassword = 'test123456';
  static const String testUserName = 'Test User';
  static const String testUserPhone = '+911234567890';

  // Test Astrologer Data
  static const String testAstrologerId = 'test_astrologer_123';
  static const String testAstrologerEmail = 'astrologer@example.com';
  static const String testAstrologerName = 'Test Astrologer';

  // Test Booking Data
  static const String testBookingId = 'test_booking_123';
  static const double testBookingAmount = 500.0;
  static const int testBookingDuration = 30;

  // Test Birth Details
  static Map<String, dynamic> get testBirthDetails => {
        'name': 'Test User',
        'day': 15,
        'month': 6,
        'year': 1990,
        'hour': 10,
        'minute': 30,
        'latitude': 28.6139,
        'longitude': 77.2090,
        'timezone': 'Asia/Kolkata',
        'place': 'New Delhi, India',
      };

  // Test Wallet Data
  static const double testWalletBalance = 1000.0;
  static const double testReferralBonus = AppConstants.referralBonus;

  // Test Horoscope Data
  static const String testZodiacSign = 'Gemini';
  static Map<String, dynamic> get testHoroscopeData => {
        'prediction': 'Today is a great day for you!',
        'love': 'Love life will be harmonious',
        'career': 'Career opportunities await',
        'health': 'Maintain good health',
        'finance': 'Financial gains expected',
        'luckyNumber': 7,
        'luckyColor': 'Blue',
      };

  // Test Chat Data
  static const String testChatMessage = 'Hello, this is a test message';
  static const String testChatBookingId = 'test_chat_booking_123';

  // Mock API Responses
  static Map<String, dynamic> get mockKundliResponse => {
        'success': true,
        'data': {
          'planets': [],
          'houses': [],
          'chart_url': 'https://test.com/chart.png',
        },
      };

  static Map<String, dynamic> get mockVarshphalResponse => {
        'success': true,
        'data': {
          'year': DateTime.now().year,
          'predictions': [],
          'chart_url': 'https://test.com/varshphal.png',
        },
      };

  static Map<String, dynamic> get mockDailyHoroscopeResponse => {
        'success': true,
        'data': testHoroscopeData,
      };
}

