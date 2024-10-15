
import 'package:flutter/material.dart';
import 'package:test01/views/screen/Buyer/buyer_home_screen.dart';
import 'package:test01/views/screen/Buyer/profile_screen.dart';
import 'package:test01/views/screen/settings_screen.dart';
class AdminHomeScreen extends StatefulWidget {
  AdminHomeScreen({super.key});

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const CounterScreen(),
    const ProfileScreen(),
    const SettingsScreen(),
  ];

  final List<Widget> _labels = [
    const Text("Mi Perfil"),
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
        title: _labels[_currentIndex],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Reports',
          ),
        ],
      ),
    );
  }
}
