
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Buyer/buyer_layout_screen.dart';
import 'package:test01/views/screen/Buyer/profile_screen.dart';
import 'package:test01/views/screen/Seller/createproduct_screen.dart';
import 'package:test01/views/screen/Seller/inventory_screen.dart';
import 'package:test01/views/widgets/navigation_bar.dart';

class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({super.key});

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
     InventoryScreen()
  ];

  final List<Widget> _label = [
    const Text("0"), 
    const Text("1"),
    const Text("2"),
    const Text("3")
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
        actions: [
          if (_currentIndex == 0)
            IconButton(
              icon: Icon(Icons.notifications), // Icono de notificaciones
              onPressed: () {
                // Acción para las notificaciones
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No hay nuevas notificaciones')),
                );
              },
            ),
          if ( _currentIndex == 3)
            IconButton(
                icon: Icon(Icons.add), // Icono para agregar productos
                onPressed: () {
                  // Acción para agregar un producto
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateProductScreen(),
                    ),
                  );
                },
              )
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: Consumer<UsuarioViewModel>(
        builder: (context, usuarioViewModel, child) {
          final role = usuarioViewModel.role ?? '';
          return CustomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            role: role,
          );
        },
      ),
    );
  }

}













