enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'PollyColleBattle';
      case Flavor.prod:
        return 'PollyColleBattle';
      default:
        return 'title';
    }
  }

}
