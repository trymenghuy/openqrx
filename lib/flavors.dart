enum Flavor {
  prod,
  stage,
  dev,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';
  static String? get db {
    switch (appFlavor) {
      case Flavor.dev:
        return 'db-dev';
      case Flavor.stage:
        return 'db-stage';
      default:
        return null;
    }
  }
}
