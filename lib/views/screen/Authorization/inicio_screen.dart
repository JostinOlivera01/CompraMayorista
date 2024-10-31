import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/auth_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';

class InicioScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final userViewModel = Provider.of<UsuarioViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: Stack(
        children: [
          // Background with slanted design
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/img/logoMayorista.png',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Button Section
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (authViewModel.user == null) ...[
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (context) => DraggableScrollableSheet(
                            expand: false,
                            initialChildSize: 0.5,
                            minChildSize: 0.4,
                            maxChildSize: 0.8,
                            builder: (context, scrollController) {
                              return Container(
                                padding: const EdgeInsets.all(16),
                                child: ListView(
                                  controller: scrollController,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 50,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextField(
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                        labelText: 'Contraseña',
                                        filled: true,
                                        fillColor: Colors.grey[200],
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      obscureText: true,
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () async {
                                        // Iniciar sesión
                                        await authViewModel.login(_emailController.text, _passwordController.text);
                                        if (authViewModel.user != null) {
                                          // Cargar el rol del usuario
                                          String? rol = await userViewModel.loadUserRole(_emailController.text);
                                          _selectHomeScreen(context, rol);
                                        } else {
                                          // Mostrar mensaje de error si el login falla
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Login failed')),
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF5e4b82),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                        child: Text('Iniciar Sesión', style: TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Center(
                                      child: TextButton(
                                        onPressed: () {
                                          // Navega a la pantalla de registro
                                          Navigator.pushNamed(context, '/register');
                                        },
                                        child: const Text(
                                          "¿No tienes cuenta? Regístrate!",
                                          style: TextStyle(color: Color(0xFF5e4b82)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5e4b82),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text(
                          'Iniciar Sesión',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFF5e4b82)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text('Registrarse', style: TextStyle(color: Color(0xFF5e4b82))),
                      ),
                    ),
                  ] else ...[
                    const Text('¡Bienvenido de nuevo!', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5e4b82),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text(
                          'Ir a la Home',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () {
                        authViewModel.signOut();
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFF5e4b82)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        child: Text('Cerrar Sesión', style: TextStyle(color: Color(0xFF5e4b82))),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rol no asignado')),
        );
        break;
    }
  }
}
