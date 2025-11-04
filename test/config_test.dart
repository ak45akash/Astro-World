import 'package:flutter_test/flutter_test.dart';
import 'package:astrology_app/core/config/app_config.dart';
import '../helpers/test_setup.dart';

void main() {
  group('AppConfig', () {
    setUp(() {
      setupTestEnvironment();
    });

    tearDown(() {
      teardownTestEnvironment();
    });

    test('should default to development environment', () {
      AppConfig.setEnvironment(Environment.development);
      expect(AppConfig.isDevelopment, true);
      expect(AppConfig.isStaging, false);
      expect(AppConfig.isProduction, false);
    });

    test('should set staging environment', () {
      AppConfig.setEnvironment(Environment.staging);
      expect(AppConfig.isStaging, true);
      expect(AppConfig.isDevelopment, false);
      expect(AppConfig.isProduction, false);
    });

    test('should set production environment', () {
      AppConfig.setEnvironment(Environment.production);
      expect(AppConfig.isProduction, true);
      expect(AppConfig.isDevelopment, false);
      expect(AppConfig.isStaging, false);
    });

    test('should set testing mode', () {
      AppConfig.setTesting(true);
      expect(AppConfig.isTesting, true);
      
      AppConfig.setTesting(false);
      expect(AppConfig.isTesting, false);
    });

    test('should return correct environment name', () {
      AppConfig.setEnvironment(Environment.development);
      expect(AppConfig.environmentName, 'development');
      
      AppConfig.setEnvironment(Environment.staging);
      expect(AppConfig.environmentName, 'staging');
      
      AppConfig.setEnvironment(Environment.production);
      expect(AppConfig.environmentName, 'production');
    });
  });
}

