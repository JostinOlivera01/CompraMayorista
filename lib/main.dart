import 'package:flutter/material.dart';
import 'package:test01/views/inicio_screen.dart';
import 'package:test01/views/login_screen.dart';
import 'package:test01/views/register_screen.dart';
import 'views/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compras Mayoristas',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const InicioScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => const MyHomePage(),
      },
    );
  }
}
