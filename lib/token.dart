import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  late final String _authToken;

  static final AuthManager _instance = AuthManager._internal();


  factory AuthManager() {
    return AuthManager._internal();
  }

  AuthManager._internal();


  // Getter para acessar o token
  String get authToken => _authToken;

  // Verifica se o usuário está logado
  bool get isLoggedIn => _authToken != null;

  // Inicia a sessão do usuário
  Future<void> login(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
    _authToken = token;
  }

  // Encerra a sessão do usuário
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    _authToken = '';
  }

  // Carrega o token da memória do dispositivo
  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _authToken = prefs.getString('authToken')!;
  }
}