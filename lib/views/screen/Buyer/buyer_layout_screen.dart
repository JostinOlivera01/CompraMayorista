import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Buyer/homeBuyer_screen.dart';
import 'package:test01/views/screen/Buyer/profile_screen.dart';
import 'package:test01/views/screen/Buyer/purchase%20order.dart';
import 'package:test01/views/screen/Buyer/widget/shopping_cart.dart';
import 'package:test01/views/widgets/navigation_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    ProductListScreen(),
    const ProfileScreen(),
    OrdersScreen(),
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

  // Método para abrir el Side Sheet
  void _openCartSideSheet(BuildContext context) {
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
        return const CartSideSheet();
      },
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: _label[_currentIndex],
      actions: _currentIndex == 0 // Índice de ProductListScreen
          ? [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => _openCartSideSheet(context),
              ),
            ]
          : null,
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