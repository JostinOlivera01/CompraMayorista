import 'package:flutter/material.dart';
import 'package:test01/views/screen/Buyer/widget/group_orders.dart';
import 'package:test01/views/screen/Buyer/widget/individual_orders.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Número de pestañas
      child: Column(
        children: [
          // Solo el TabBar, sin AppBar ni Scaffold extra
          TabBar(
            tabs: [
              Tab(text: 'Individuales'),
              Tab(text: 'Grupales'),
            ],
          ),
          Expanded(
            // TabBarView necesita ser contenido por un widget que expanda, en este caso `Expanded`
            child: TabBarView(
              children: [
                IndividualOrdersScreen(),
                GroupOrdersScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
