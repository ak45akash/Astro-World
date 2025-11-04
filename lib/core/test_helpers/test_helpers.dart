import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';
import '../config/test_constants.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../models/user_model.dart';
import '../services/astrology_service.dart';
import '../services/mock_astrology_service.dart';
import '../services/mock_auth_repository.dart';

/// Helper class for setting up test environment
class TestHelpers {
  /// Initialize test environment
  static void initializeTestEnvironment() {
    AppConfig.setTesting(true);
    AppConfig.setEnvironment(Environment.development);
  }

  /// Create a test UserModel
  static UserModel createTestUser({
    String? id,
    String? email,
    String? role,
  }) {
    return UserModel(
      id: id ?? TestConstants.testUserId,
      email: email ?? TestConstants.testUserEmail,
      displayName: TestConstants.testUserName,
      phoneNumber: TestConstants.testUserPhone,
      role: role ?? 'end_user',
      createdAt: DateTime.now(),
      referralCode: 'TEST123',
    );
  }

  /// Create a test ProviderContainer with mock providers
  static ProviderContainer createTestContainer({
    AuthRepository? authRepository,
    AstrologyService? astrologyService,
  }) {
    final container = ProviderContainer(
      overrides: [
        if (authRepository != null)
          authRepositoryProvider.overrideWithValue(authRepository),
        // Add other provider overrides as needed
      ],
    );

    return container;
  }

  /// Create a test Widget with Riverpod providers
  static Widget wrapWithProviders(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  /// Create mock AuthRepository
  static MockAuthRepository createMockAuthRepository() {
    return MockAuthRepository();
  }

  /// Create mock AstrologyService
  static MockAstrologyService createMockAstrologyService() {
    return MockAstrologyService();
  }

  /// Reset test environment
  static void resetTestEnvironment() {
    AppConfig.setTesting(false);
  }
}

/// Test data factory
class TestDataFactory {
  static Map<String, dynamic> createBirthDetails({
    String? name,
    int? day,
    int? month,
    int? year,
  }) {
    final details = Map<String, dynamic>.from(TestConstants.testBirthDetails);
    if (name != null) details['name'] = name;
    if (day != null) details['day'] = day;
    if (month != null) details['month'] = month;
    if (year != null) details['year'] = year;
    return details;
  }

  static Map<String, dynamic> createBookingData({
    String? userId,
    String? astrologerId,
    double? amount,
  }) {
    return {
      'userId': userId ?? TestConstants.testUserId,
      'astrologerId': astrologerId ?? TestConstants.testAstrologerId,
      'type': 'chat',
      'scheduledAt': DateTime.now().add(const Duration(hours: 1)),
      'durationMinutes': TestConstants.testBookingDuration,
      'amount': amount ?? TestConstants.testBookingAmount,
      'status': 'pending',
      'createdAt': DateTime.now(),
    };
  }
}

