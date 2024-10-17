
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Buyer/buyer_home_screen.dart';
import 'package:test01/views/screen/Buyer/profile_screen.dart';
import 'package:test01/views/screen/Seller/createproduct_screen.dart';
import 'package:test01/views/screen/settings_screen.dart';
import 'package:test01/views/widgets/navigation_bar.dart';

class SellerHomeScreen extends StatefulWidget {
  SellerHomeScreen({super.key});

  @override
  _SellerHomeScreenState createState() => _SellerHomeScreenState();
}

class _SellerHomeScreenState extends State<SellerHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    // Añade aquí las pantallas reales que quieras mostrar en cada tab
    const CounterScreen(),
    const ProfileScreen(),
    const CreateProductScreen(),
  ];

  final List<Widget> _label = [
    const Text("0"), 
    const Text("1"),
    const Text("2"),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _label[_currentIndex],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Consumer<UsuarioViewModel>(
        builder: (context, usuarioViewModel, child) {
          final role = usuarioViewModel.role ?? '';
          print("Rol actual: $role"); // Obtener el rol del ViewModel
          return CustomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            role: role, // Pasar el rol dinámicamente
          );
        },
      ),
    );
  }
}













