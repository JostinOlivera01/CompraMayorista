// views/register_screen.dart
import 'package:flutter/material.dart';
import '../viewmodels/auth_viewmodel.dart';

class RegisterScreen extends StatelessWidget {
  final AuthViewModel authViewModel = AuthViewModel();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirmar Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simple lógica de registro
                if (_passwordController.text == _confirmPasswordController.text) {
                  authViewModel.register(_usernameController.text, _passwordController.text);
                  Navigator.pushReplacementNamed(context, '/login');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Las contraseñas no coinciden')),
                  );
                }
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
