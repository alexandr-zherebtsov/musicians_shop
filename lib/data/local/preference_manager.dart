import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const String _fcmToken = 'fcmToken';

  Future<SharedPreferences> _pref() async => await SharedPreferences.getInstance();

  Future<bool> setFcmToken(final String? e) async {
    final SharedPreferences pref = await _pref();
    return await pref.setString(_fcmToken, e ?? '');
  }

  Future<String> getFcmToken() async {
    final SharedPreferences pref = await _pref();
    return pref.getString(_fcmToken) ?? '';
  }

  Future<void> clear() async {
    final SharedPreferences pref = await _pref();
    await pref.clear();
  }
}
