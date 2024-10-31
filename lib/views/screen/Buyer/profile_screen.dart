import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/auth_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Authorization/inicio_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final authViewModel = Provider.of<AuthViewModel>(context);
      final emailViewModel = Provider.of<UsuarioViewModel>(context);
      final email = emailViewModel.email ?? ''; // Valor por defecto si es nulo

        

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ElevatedButton(
          onPressed: () {
            const email = "";
            authViewModel.signOut(context);
            Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => InicioScreen()),
            (Route<dynamic> route) => false,);
            },
          child: const Text('Cerrar Sesión'),
            ),],
       ),
    );
  }





  
}