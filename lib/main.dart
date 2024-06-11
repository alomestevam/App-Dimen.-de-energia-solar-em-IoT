import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'dimensionamento.dart';
import 'monitoramento.dart';
import 'configuracoes.dart';
import 'integracao_iot.dart';
import 'perfil_usuario.dart';
import 'suporte.dart';
import 'home_page.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'splash_screen.dart';  

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dimen. Energia Solar em IOT',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', 
      routes: {
        '/': (context) => SplashScreen(), 
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/dashboard': (context) => Dashboard(),
        '/dimensionamento': (context) => Dimensionamento(),
        '/monitoramento': (context) => Monitoramento(),
        '/configuracoes': (context) => Configuracoes(),
        '/integracao_iot': (context) => IntegracaoIoT(),
        '/perfil_usuario': (context) => PerfilUsuario(),
        '/suporte': (context) => Suporte(),
        '/home_page': (context) => HomePage(),        
      },
    );
  }
}
