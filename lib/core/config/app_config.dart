enum Environment {
  development,
  staging,
  production,
}

class AppConfig {
  static Environment _environment = Environment.development;
  static bool _isTesting = false;

  static Environment get environment => _environment;
  static bool get isTesting => _isTesting;
  static bool get isDevelopment => _environment == Environment.development;
  static bool get isStaging => _environment == Environment.staging;
  static bool get isProduction => _environment == Environment.production;

  static void setEnvironment(Environment env) {
    _environment = env;
  }

  static void setTesting(bool testing) {
    _isTesting = testing;
  }

  static String get environmentName {
    switch (_environment) {
      case Environment.development:
        return 'development';
      case Environment.staging:
        return 'staging';
      case Environment.production:
        return 'production';
    }
  }
}

