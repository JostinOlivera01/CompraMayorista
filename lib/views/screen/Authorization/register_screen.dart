// views/screen/register_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/auth_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? selectedRole; // Variable para almacenar el rol seleccionado

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final usuarioViewModel = Provider.of<UsuarioViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: 'Password')),
            
            // Dropdown para seleccionar el rol
            DropdownButton<String>(
              value: selectedRole,
              hint: Text("Selecciona tu rol"),
              items: ['administrador', 'comprador', 'vendedor'].map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (String? newValue) {
                selectedRole = newValue; // Actualizar el rol seleccionado
              },
            ),
            
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {

                if (selectedRole != null) {
                  await authViewModel.register(_emailController.text, _passwordController.text);
                  await usuarioViewModel.registerUser(
                    _emailController.text,
                    _passwordController.text,
                    selectedRole!, // Pasar el rol seleccionado
                    _emailController.text,
                  );
                  Navigator.pushReplacementNamed(context, '/login');
                } else {
                  // Mostrar alerta si no se selecciona el rol
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Error"),
                        content: Text("Por favor selecciona un rol."),
                        actions: <Widget>[
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text("Register"),
            )
          ],
        ),
      ),
    );
  }


}
