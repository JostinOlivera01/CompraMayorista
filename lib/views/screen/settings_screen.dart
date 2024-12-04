import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/auth_viewmodel.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure authViewModel is available through Provider or similar method
    final authViewModel = Provider.of<AuthViewModel>(context);  // Make sure to replace with your actual provider

    return Center(
      child: ElevatedButton(
        onPressed: () {
          authViewModel.signOut(context);  // Cerrar sesión
        },
        child: const Text('Cerrar Sesión'),
      ),
    );
  }
}
