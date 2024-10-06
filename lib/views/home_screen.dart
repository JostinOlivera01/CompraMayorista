
import 'package:flutter/material.dart';
import 'package:test01/views/profile_screen.dart';
import 'package:test01/views/settings_screen.dart';
import 'package:test01/widgets/navigation_bar.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CounterScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
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
        title: const Text('Barra de Navegación Inferior Fija'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
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
            )
          ],
        ),
      );
  }
}