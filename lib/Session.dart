import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static final SessionManager _instance = SessionManager._internal();
  SharedPreferences? _prefs;

  factory SessionManager() {
    return _instance;
  }

  SessionManager._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveUserSession(Map<String, dynamic> userSession) async {
    await _prefs?.setStringList('user_data', userSession['user_data']);

    await _prefs?.setString('user', userSession['user']);

    // adicione outros campos de usuário conforme necessário
  }

  Map<String, dynamic> getUserSession() {
    final user_data = _prefs?.getInt('user_data');
    final user = _prefs?.getString('user');
    // adicione outros campos de usuário conforme necessário
    return {
      'user_data': user_data,
      'user': user,

      // adicione outros campos de usuário conforme necessário
    };
  }

  Future<void> clearUserSession() async {
    await _prefs?.remove('user');
    await _prefs?.remove('user_data');

    // adicione outros campos de usuário conforme necessário
  }
}