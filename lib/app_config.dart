enum Flavor { production, staging }

class AppConfig {

  AppConfig({required this.flavor, required this.appLabel, required this.scheme, required this.scope, required this.host, required this.msTenantID});

  factory AppConfig.initiate() {
    return shared = AppConfig(
        flavor: Flavor.staging,
        appLabel: 'Work Wizard',
        msTenantID: 'cf77e474-cc9d-443d-9ae3-91c0c0121362',
        scheme: 'https',
        scope: 'api/v1',
        host: 'rnkkq-27-60-174-213.a.free.pinggy.link');
  }
  Flavor flavor;
  String appLabel;
  String scheme;
  String scope;
  String host;
  String msTenantID;

  static AppConfig shared = AppConfig.initiate();
}
