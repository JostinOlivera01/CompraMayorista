import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/auth_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final userViewModel = Provider.of<UsuarioViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Iniciar sesión y verificar si fue exitoso
                await authViewModel.login(_emailController.text, _passwordController.text);
                if (authViewModel.user != null) {
                 String? rol  = await userViewModel.loadUserRole(_emailController.text);
                  _selectHomeScreen(context, rol);
                } else {
                  // Manejo de errores de inicio de sesión
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login failed')),
                  );
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

  // Método para seleccionar la pantalla inicial según el rol
  void _selectHomeScreen(BuildContext context, String? role) {
    switch (role) {
      case 'administrador':
        Navigator.pushReplacementNamed(context, '/adminHome');
        break;
      case 'comprador':
        Navigator.pushReplacementNamed(context, '/buyerHome');
        break;
      case 'vendedor':
        Navigator.pushReplacementNamed(context, '/sellerHome');
        break;
      default:
        // Si no hay rol definido, vuelve a la pantalla de login
        Navigator.pushReplacementNamed(context, '/login');
        break;
    }
  }
}
