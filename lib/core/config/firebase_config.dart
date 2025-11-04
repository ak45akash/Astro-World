import 'package:firebase_core/firebase_core.dart';
import 'app_config.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (AppConfig.isTesting) {
      return _getTestConfig();
    }

    switch (AppConfig.environment) {
      case Environment.development:
        return _getDevelopmentConfig();
      case Environment.staging:
        return _getStagingConfig();
      case Environment.production:
        return _getProductionConfig();
    }
  }

  static FirebaseOptions _getTestConfig() {
    return const FirebaseOptions(
      apiKey: 'TEST_API_KEY',
      appId: 'TEST_APP_ID',
      messagingSenderId: 'TEST_MESSAGING_SENDER_ID',
      projectId: 'astrology-app-test',
      authDomain: 'astrology-app-test.firebaseapp.com',
      storageBucket: 'astrology-app-test.appspot.com',
    );
  }

  static FirebaseOptions _getDevelopmentConfig() {
    return const FirebaseOptions(
      apiKey: 'DEV_API_KEY',
      appId: 'DEV_APP_ID',
      messagingSenderId: 'DEV_MESSAGING_SENDER_ID',
      projectId: 'astrology-app-dev',
      authDomain: 'astrology-app-dev.firebaseapp.com',
      storageBucket: 'astrology-app-dev.appspot.com',
    );
  }

  static FirebaseOptions _getStagingConfig() {
    return const FirebaseOptions(
      apiKey: 'STAGING_API_KEY',
      appId: 'STAGING_APP_ID',
      messagingSenderId: 'STAGING_MESSAGING_SENDER_ID',
      projectId: 'astrology-app-staging',
      authDomain: 'astrology-app-staging.firebaseapp.com',
      storageBucket: 'astrology-app-staging.appspot.com',
    );
  }

  static FirebaseOptions _getProductionConfig() {
    return const FirebaseOptions(
      apiKey: 'PROD_API_KEY',
      appId: 'PROD_APP_ID',
      messagingSenderId: 'PROD_MESSAGING_SENDER_ID',
      projectId: 'astrology-app-prod',
      authDomain: 'astrology-app-prod.firebaseapp.com',
      storageBucket: 'astrology-app-prod.appspot.com',
    );
  }
}
