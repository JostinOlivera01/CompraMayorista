import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/business_logic/models/orders_model.dart';
import 'package:test01/viewmodels/Pagos_viewmdel/Orders_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Buyer/widget/orderCard.dart';

class IndividualOrdersScreen extends StatelessWidget {
  const IndividualOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrdersViewmodel>(context);
    final user = Provider.of<UsuarioViewModel>(context);

    return FutureBuilder<List<OrderModel>>(
      future: orderViewModel.fetchPaymented(user.email!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar pedidos'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay pedidos disponibles'));
        }

        final orders = snapshot.data!;
        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];

            return OrderCard(
              productName: order.title,
              productImageUrl: 'https://img.freepik.com/fotos-premium/planta-embotellado-linea-embotellado-agua-procesar-embotellar-agua-pura-manantial-botellas-azules-enfoque-selectivo_473712-850.jpg?w=360',
              price: order.unit_price * order.quantity,
              status: order.status,
              creationDate: order.createdAt,
              onTap: () async {


              },
            );
          },
        );
      },
    );
  }
}
