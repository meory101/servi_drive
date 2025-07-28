

abstract class AppConstantManager {
  static const bool stagingEnv = false;
  static const String assetTranslationPath = 'assets/translations';
  static const String appIpConnectionTest = '8.8.8.8';
  static const String baseUrl = "chamsale.justfortesting.ovh/api";
  static String isoCode ="SY";

  static String imageLoader({required String imageAsBase64}) =>
      "/9j/2wBDAP//////////////////////////////////////////////////////////////////////////////////////2wBDAf//////////////////////////////////////////////////////////////////////////////////////$imageAsBase64";
}
