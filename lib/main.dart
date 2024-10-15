import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test01/business_logic/actions/User_actions/auth_actions.dart';
import 'package:test01/business_logic/actions/User_actions/usuarioStore_actions.dart';
import 'package:test01/business_logic/service/authService.dart';
import 'package:test01/business_logic/service/usuarioStoreService.dart';
import 'package:test01/viewmodels/User_viewmodel/auth_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Admin/admin_home_screen.dart';
import 'package:test01/views/screen/Seller/seller_home_screen.dart';
import 'views/screen/Buyer/buyer_home_screen.dart';
import 'views/screen/Authorization/login_screen.dart';
import 'views/screen/Authorization/register_screen.dart';
import 'views/screen/Buyer/inicio_screen.dart';

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
        ChangeNotifierProvider(
          create: (_) => UsuarioViewModel(UsuarioCaseStore(UsuarioStoreService())),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
final String? role; // Agregar un parámetro de rol

  MyApp({this.role}); // Constructor para recibir el rol

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => InicioScreen(), // Pantalla inicial según el rol
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/buyerHome': (context) => MyHomePage(),
        '/adminHome': (context) => AdminHomeScreen(),
        '/sellerHome': (context) => SellerHomeScreen(),
      },
    );
  }
}

