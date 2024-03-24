import 'package:shared_preferences/shared_preferences.dart';

abstract interface class IPreferenceManager {
  Future<bool> setFcmToken(final String? e);

  Future<String> getFcmToken();

  Future<void> clear();
}

final class PreferenceManager implements IPreferenceManager {
  static const String _fcmToken = 'fcmToken';

  static Future<SharedPreferences> get _pref => SharedPreferences.getInstance();

  @override
  Future<bool> setFcmToken(final String? e) async {
    final SharedPreferences pref = await _pref;
    return await pref.setString(_fcmToken, e ?? '');
  }

  @override
  Future<String> getFcmToken() async {
    final SharedPreferences pref = await _pref;
    return pref.getString(_fcmToken) ?? '';
  }

  @override
  Future<void> clear() async {
    final SharedPreferences pref = await _pref;
    await pref.clear();
  }
}
