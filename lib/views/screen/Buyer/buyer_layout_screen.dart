import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Buyer/profile_screen.dart';
import 'package:test01/views/screen/Buyer/purchase%20order.dart';
import 'package:test01/views/screen/Buyer/widget/cart_sheets.dart';
import 'package:test01/views/screen/settings_screen.dart';
import 'package:test01/views/widgets/advertisements.dart';
import 'package:test01/views/widgets/navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    AdvertisementListScreen(), 
    OrdersScreen(),
    ProfileScreen(),
  ];

  final List<Widget> _label = [
    const Text("Anuncios"),
    const Text("Grupos"),
    const Text("Órdenes"),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Método para abrir el Side Sheet
  void _openCartSideSheet(BuildContext context) {
    final emailviewmodel = Provider.of<UsuarioViewModel>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return CartSideSheet(buyerEmail: emailviewmodel.email ?? '');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: _currentIndex == 0
            ? IconButton(
                icon: const Icon(Icons.account_circle), // Ícono de usuario
                onPressed: () {
                  // Acción futura para "Mi Perfil"
                },
              )
            : null, // Ícono de usuario solo en la primera pantalla
        actions: [
          if (_currentIndex == 0) // Ícono del carrito solo en la primera pantalla
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => _openCartSideSheet(context),
            ),
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













class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++; // Cambia el estado
    });
  }
  void _disminuirCounter(){
    setState(() {
      _counter--;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Presiona el botón para incrementar el contador:'),
            Text(
              '$_counter', // Muestra el estado actual
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: _incrementCounter, // Incrementa el contador al presionar
                    child: const Icon(Icons.add),
                    ),
                ElevatedButton(
                    onPressed: _disminuirCounter, // Incrementa el contador al presionar
                    child: const Icon(Icons.remove),
                    )

              ],
            ),
            
          ],
        ),
      );
  }
}











