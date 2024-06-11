import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/users.txt');

      if (await file.exists()) {
        try {
          final List<String> lines = await file.readAsLines();
          bool isAuthenticated = false;
          for (var line in lines) {
            final parts = line.split(',');
            if (parts.length == 2 && parts[0] == _usernameController.text && parts[1] == _passwordController.text) {
              isAuthenticated = true;
              break;
            }
          }

          if (isAuthenticated) {
            Navigator.pushReplacementNamed(context, '/home_page');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Credenciais inválidas')));
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro ao ler dados de usuário')));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nenhum usuário registrado')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Stack(
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
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Login'),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text('Não tem conta? Crie uma agora'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
