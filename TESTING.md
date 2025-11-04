# Testing Configuration Guide

This document explains how to use the testing configuration for the Astrology App.

## Overview

The app supports multiple environments:
- **Development**: For local development
- **Staging**: For staging/testing environment
- **Production**: For production deployment
- **Testing**: For unit and widget tests

## Configuration

### Environment Setup

The app uses `AppConfig` to manage environments:

```dart
import 'package:astrology_app/core/config/app_config.dart';

// Set environment
AppConfig.setEnvironment(Environment.development);
AppConfig.setEnvironment(Environment.staging);
AppConfig.setEnvironment(Environment.production);

// Enable testing mode
AppConfig.setTesting(true);
```

### Firebase Configuration

Firebase configuration automatically switches based on the environment:

- **Test**: Uses `astrology-app-test` project
- **Development**: Uses `astrology-app-dev` project
- **Staging**: Uses `astrology-app-staging` project
- **Production**: Uses `astrology-app-prod` project

Update `lib/core/config/firebase_config.dart` with your actual Firebase project configurations.

## Mock Services

### MockAstrologyService

Use `MockAstrologyService` for testing astrology-related functionality:

```dart
import 'package:astrology_app/core/services/mock_astrology_service.dart';

final mockService = MockAstrologyService();
final kundli = await mockService.generateKundli(...);
```

### MockAuthRepository

Use `MockAuthRepository` for testing authentication:

```dart
import 'package:astrology_app/core/services/mock_auth_repository.dart';

final mockAuth = MockAuthRepository();
final credential = await mockAuth.signInWithEmail(
  email: 'test@example.com',
  password: 'password123',
);
```

## Test Helpers

Use `TestHelpers` for common test setup:

```dart
import 'package:astrology_app/core/test_helpers/test_helpers.dart';

// Initialize test environment
TestHelpers.initializeTestEnvironment();

// Create test user
final testUser = TestHelpers.createTestUser();

// Create test container with mock providers
final container = TestHelpers.createTestContainer(
  authRepository: mockAuth,
  astrologyService: mockService,
);

// Wrap widget with providers
final widget = TestHelpers.wrapWithProviders(MyWidget());
```

## Test Constants

Use `TestConstants` for test data:

```dart
import 'package:astrology_app/core/config/test_constants.dart';

// Test user data
final email = TestConstants.testUserEmail;
final password = TestConstants.testUserPassword;

// Test birth details
final birthDetails = TestConstants.testBirthDetails;

// Mock API responses
final mockResponse = TestConstants.mockKundliResponse;
```

## Running Tests

### Unit Tests

```bash
flutter test
```

### Widget Tests

```bash
flutter test test/widget_test.dart
```

### Integration Tests

```bash
flutter test integration_test/
```

### Run Specific Test File

```bash
flutter test test/services/mock_astrology_service_test.dart
```

## Test Setup

All tests should use the test setup helpers:

```dart
import '../helpers/test_setup.dart';

void main() {
  setUp(() {
    setupTestEnvironment();
  });

  tearDown(() {
    teardownTestEnvironment();
  });

  test('my test', () {
    // Test code
  });
}
```

Or use the `testGroup` wrapper:

```dart
import '../helpers/test_setup.dart';

void main() {
  testGroup('MyFeature', () {
    test('should do something', () {
      // Test code
    });
  });
}
```

## Build Flavors (Optional)

You can set up Flutter build flavors for different environments:

### Android (android/app/build.gradle)

```gradle
android {
    flavorDimensions "environment"
    productFlavors {
        dev {
            dimension "environment"
            applicationIdSuffix ".dev"
        }
        staging {
            dimension "environment"
            applicationIdSuffix ".staging"
        }
        prod {
            dimension "environment"
        }
    }
}
```

### iOS (ios/Runner.xcodeproj)

Create different schemes in Xcode for each environment.

### Run with Flavor

```bash
# Development
flutter run --flavor dev

# Staging
flutter run --flavor staging

# Production
flutter run --flavor prod
```

## Environment Variables

For production, use environment variables:

```dart
// In main.dart or config file
final apiKey = Platform.environment['ASTROLOGY_API_KEY'] ?? 'default_key';
```

## Best Practices

1. **Always use test helpers** for consistent test setup
2. **Use mock services** instead of real API calls in tests
3. **Reset test environment** in tearDown
4. **Use test constants** for consistent test data
5. **Separate unit, widget, and integration tests**
6. **Test all user roles** (end_user, astrologer, admin, etc.)
7. **Test error scenarios** as well as success cases

## Test Coverage

Run tests with coverage:

```bash
flutter test --coverage
```

View coverage report:

```bash
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Continuous Integration

Example CI configuration (GitHub Actions):

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test --coverage
```

