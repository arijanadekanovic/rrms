enum Environment {
  mock,
  development,
  staging,
  production;

  bool get isMock => this == Environment.mock;
  bool get isDevelopment => this == Environment.development;
  bool get isStaging => this == Environment.staging;
  bool get isProduction => this == Environment.production;
}
