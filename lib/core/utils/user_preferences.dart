import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  late SharedPreferencesWithCache prefs;
  bool _showPrivacyPage = true;

  static final _instance = UserPreferences._();
  factory UserPreferences.instance() => _instance;
  new _();
  
  bool get showPrivacyPage => _showPrivacyPage;

  Future<void> loadPrefs() async {
    prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{"showPrivacyPage"}
      )
    );
    _showPrivacyPage = prefs.getBool("showPrivacyPage") ?? true;
  }

  Future<void> changePrefs() async {
    _showPrivacyPage = false;
    await prefs.setBool("showPrivacyPage", _showPrivacyPage);
  }
}