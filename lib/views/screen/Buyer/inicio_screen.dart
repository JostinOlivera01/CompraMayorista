// views/start_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/auth_viewmodel.dart';
import 'package:test01/views/screen/Buyer/buyer_home_screen.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Acceder al AuthViewModel para observar el estado de autenticación
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Revisar si el usuario está autenticado o no
            if (authViewModel.user == null) ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Iniciar Sesión'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Registrarse'),
              ),
            ] else ...[
              const Text('¡Bienvenido de nuevo!'),
              ElevatedButton(
                onPressed: () {
                  MyHomePage();
                },
                child: const Text('Ir a la Home'),
              ),
              ElevatedButton(
                onPressed: () {
                  authViewModel.signOut();  // Cerrar sesión
                },
                child: const Text('Cerrar Sesión'),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
