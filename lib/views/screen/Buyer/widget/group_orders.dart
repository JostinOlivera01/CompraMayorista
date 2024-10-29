import 'package:flutter/material.dart';

class GroupOrdersScreen extends StatelessWidget {
  const GroupOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Órdenes de Compra Grupales',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
