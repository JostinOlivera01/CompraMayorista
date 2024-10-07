import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/auth_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final authViewModel = Provider.of<AuthViewModel>(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ElevatedButton(
          onPressed: () {
            authViewModel.signOut();
            Navigator.pushNamed(context, '/');
                
            },
          child: const Text('Cerrar Sesión'),
            ),],
       ),
    );
  }





  
}