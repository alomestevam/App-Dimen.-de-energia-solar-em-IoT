import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class UserRepository {
  final String _filePath = 'users.txt';

  Future<List<String>> loadUsers() async {
    try {
      final File file = File(_filePath);
      if (!(await file.exists())) {
        return [];
      }
      final List<String> lines = await file.readAsLines();
      return lines;
    } catch (e) {
      print('Erro ao carregar usuários: $e');
      return [];
    }
  }

  Future<void> addUser(String username, String password) async {
    try {
      final File file = File(_filePath);
      IOSink sink = file.openWrite(mode: FileMode.append);
      sink.write('$username,$password\n');
      await sink.flush();
      await sink.close();
    } catch (e) {
      print('Erro ao adicionar usuário: $e');
    }
  }
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final UserRepository _userRepository = UserRepository();

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text == _confirmPasswordController.text) {
        await _userRepository.addUser(_usernameController.text, _passwordController.text);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Usuário registrado com sucesso!')));
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('As senhas não coincidem')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: [
              // Background image
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/fundo.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Form
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(labelText: 'Username'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira seu nome de usuário';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira sua senha';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(labelText: 'Confirm Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, confirme sua senha';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _register,
                        child: Text('Registrar'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
