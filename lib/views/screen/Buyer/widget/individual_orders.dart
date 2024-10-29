import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/business_logic/models/orders_model.dart';
import 'package:test01/viewmodels/Product_viewmodel/Orders_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Buyer/paymentMercado_screen.dart';
import 'package:test01/views/screen/Buyer/widget/orderCard.dart';

class IndividualOrdersScreen extends StatelessWidget {
  const IndividualOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrdersViewmodel>(context);
    final User = Provider.of<UsuarioViewModel>(context);

    return FutureBuilder<List<OrderModel>>(
      future: orderViewModel.fetchOrderInv(User.email!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error al cargar productos'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hay productos disponibles'));
        }

        final products = snapshot.data!;
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            return OrderCard(
              productName: product.name,
              productImageUrl: 'https://img.freepik.com/fotos-premium/planta-embotellado-linea-embotellado-agua-procesar-embotellar-agua-pura-manantial-botellas-azules-enfoque-selectivo_473712-850.jpg?w=360',
              price: product.price,
              status: product.status,
              creationDate: DateTime.now(),
              onTap: () async {
                final paymentUrl = await orderViewModel.initiatePayment(
                  product.name,
                  1,
                  product.price,
                  User.email ?? 'defaultUserEmail@example.com',
                  product.email,
                  product.productID,
                  product.orderID
                );

                if (paymentUrl != null) {
                  // Navegar y esperar el resultado del pago
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentWebView(sandboxUrl: paymentUrl),
                    ),
                  );

                  // Verificar si el pago fue exitoso
                  if (result == 'success') {
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error al iniciar el pago')),
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}