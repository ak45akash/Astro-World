import 'package:flutter_test/flutter_test.dart';
import 'package:astrology_app/core/config/app_config.dart';
import 'package:astrology_app/core/test_helpers/test_helpers.dart';

/// Setup function to be called before all tests
void setupTestEnvironment() {
  TestHelpers.initializeTestEnvironment();
}

/// Teardown function to be called after all tests
void teardownTestEnvironment() {
  TestHelpers.resetTestEnvironment();
}

/// Test group wrapper that sets up and tears down test environment
void testGroup(String description, void Function() body) {
  group(description, () {
    setUp(() {
      setupTestEnvironment();
    });

    tearDown(() {
      teardownTestEnvironment();
    });

    body();
  });
}

