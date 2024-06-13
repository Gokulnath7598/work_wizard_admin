enum Flavor { production, staging }

class AppConfig {

  AppConfig({required this.flavor, required this.appLabel, required this.scheme, required this.scope, required this.host});

  factory AppConfig.initiate() {
    return shared = AppConfig(
        flavor: Flavor.staging,
        appLabel: 'Work Wizard',
        scheme: 'https',
        scope: 'api/v1',
        host: 'api.velichamgrow.com');
  }
  Flavor flavor;
  String appLabel;
  String scheme;
  String scope;
  String host;

  static AppConfig shared = AppConfig.initiate();
}
