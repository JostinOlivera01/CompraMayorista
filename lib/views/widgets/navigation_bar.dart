// widgets/navigation_bar.dart
import 'package:flutter/material.dart';
class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String role;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> adminItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Admin Inicio'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Admin Perfil'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Admin Ajustes'),
    ];

    List<BottomNavigationBarItem> buyerItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Compras'),
      BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
    ];

    List<BottomNavigationBarItem> sellerItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
      BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Mis Anuncios'),
      BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Ventas'),
      BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Inventario'),
    ];

    // Escoger los items basados en el rol
    List<BottomNavigationBarItem> items;
    switch (role) {
      case 'administrador':
        items = adminItems;
        break;
      case 'comprador':
        items = buyerItems;
        break;
      case 'vendedor':
        items = sellerItems;
        break;
      default:
        // Items por defecto en caso de rol desconocido
        items = [
          BottomNavigationBarItem(icon: Icon(Icons.error), label: 'Error'),
          BottomNavigationBarItem(icon: Icon(Icons.error), label: 'Error'),
        ];
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black, 
      unselectedItemColor: Colors.black
    );
  }
}
