import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:manutencao_flutter/Session.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _portController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> login() async {
    String host = _hostController.text;
    String port = _portController.text;
    String user = _userController.text;
    String password = _passwordController.text;

    var url = Uri.parse('http://$host:$port/usuario/login/');

    print(host);
    print(port);
    print(user);
    print(password);
    print(url);
    try {
      var response = await http.post(
        url,
        body: {'matricula': user, 'senha': password},
      );

      if (response.statusCode == 200) {
        // login com sucesso
        print('login realizado com sucesso');
        final userSession = jsonDecode(response.body);
        await SessionManager().saveUserSession(userSession['user']);
        // Recuperar a sessão do usuário após o login

        final getSession = SessionManager().getUserSession();
        print(await getSession['nome']);
        print(response.body);
      } else {
        // erro no login
        print('erro ao realizar login');
      }
    } catch (e) {
      // erro ao enviar requisição
      print('erro ao enviar requisição: $e');
    }
  }
  @override
  _LoginPageState createState() => _LoginPageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffa6c9ff),
              Color(0xffecf3fc),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(15, 62, 144, 0.582),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/logo_map1.png', height: 100),

                      TextFormField(
                        inputFormatters: [NoSpaceFormatter()],
                        controller: _hostController,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'HOST',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white )
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)
                          )
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        inputFormatters: [NoSpaceFormatter()],
                        controller: _portController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelStyle: TextStyle(color: Colors.white),
                          labelText: 'PORT',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white )
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.lightBlue)
                            )

                        ),
                      ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _userController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Matrícula',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white )
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)
                        )
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Senha',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white )
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue)
                        )
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: const Text('Entrar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class NoSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.replaceAll(' ', ''),
      selection: newValue.selection,
    );
  }
}
