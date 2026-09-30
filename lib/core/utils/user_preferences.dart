import 'package:shared_preferences/shared_preferences.dart';

final class VerifyPrivacyScreen._() {
  late SharedPreferencesWithCache prefs;
  bool _showPrivacyScreen = true;

  static final _instance = VerifyPrivacyScreen._();
  factory VerifyPrivacyScreen.instance() => _instance;

  bool get showPrivacyScreen => _showPrivacyScreen;

  Future<void> loadPrefs() async {
    prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{"showPrivacyScreen"},
      ),
    );
    _showPrivacyScreen = prefs.getBool("showPrivacyScreen") ?? true;
  }

  Future<void> changePrefs() async {
    _showPrivacyScreen = false;
    await prefs.setBool("showPrivacyScreen", _showPrivacyScreen);
  }
}
