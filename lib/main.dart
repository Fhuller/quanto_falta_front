import 'package:flutter/material.dart';
import 'package:quanto_falta_front/screens/login/login_page.dart';
import 'package:quanto_falta_front/screens/register.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quanto Falta',
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        '/': (context) => const Login(),
        '/register': (context) => const Register()
      },
      initialRoute: '/',
    );
  }
}
