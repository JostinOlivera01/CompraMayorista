import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/auth_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tu lógica actual del build permanece igual
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
                final userViewModel = Provider.of<UsuarioViewModel>(context, listen: false);

                await authViewModel.login(
                  _emailController.text,
                  _passwordController.text,
                );

                if (authViewModel.user != null) {
                  final role = await userViewModel.loadUserRole(_emailController.text);
                  _selectHomeScreen(context, role);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login failed')),
                  );
                }
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }

  void _selectHomeScreen(BuildContext context, String? role) {
    final route = role == 'administrador'
        ? '/adminHome'
        : role == 'comprador'
            ? '/buyerHome'
            : role == 'vendedor'
                ? '/sellerHome'
                : '/login';

    Navigator.pushReplacementNamed(context, route);
  }
}
