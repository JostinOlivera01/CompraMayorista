// widgets/navigation_bar.dart
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String role;  // Añadimos el rol del usuario

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.role,  // Recibimos el rol
  });

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> _adminItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Admin Inicio'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Admin Perfil'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Admin Ajustes'),
    ];

    List<BottomNavigationBarItem> _buyerItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Compras'),
      BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
    ];

    List<BottomNavigationBarItem> _sellerItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
      BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Mis Productos'),
      BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Ventas'),
    ];

    // Escoger los items basados en el rol
    List<BottomNavigationBarItem> items;
    switch (role) {
      case 'administrador':
        items = _adminItems;
        break;
      case 'comprador':
        items = _buyerItems;
        break;
      case 'vendedor':
        items = _sellerItems;
        break;
      default:
        items = [];
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
    );
  }
}
