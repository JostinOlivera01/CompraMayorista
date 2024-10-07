// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test01/business_logic/actions/User_actions/auth_actions.dart';
import 'package:test01/business_logic/service/authService.dart';
import 'package:test01/viewmodels/User_viewmodel/auth_viewmodel.dart';
import 'views/screen/home_screen.dart';
import 'views/screen/login_screen.dart';
import 'views/screen/register_screen.dart';
import 'views/screen/inicio_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => AuthService()),
        ChangeNotifierProvider(
          create: (context) => AuthViewModel(AuthUseCase(context.read<AuthService>())),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => InicioScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => MyHomePage(),
      },
    );
  }
}

