



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/business_logic/models/orders_model.dart';
import 'package:test01/viewmodels/Product_viewmodel/Orders_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Buyer/paymentMercado_screen.dart';
import 'package:test01/views/screen/Buyer/widget/orderCard.dart';

class CartSideSheet extends StatelessWidget {
  const CartSideSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrdersViewmodel>(context);
    final user = Provider.of<UsuarioViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Carrito de Compras',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<OrderModel>>(
              future: orderViewModel.fetchOrderInv(user.email!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar productos'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay productos disponibles'));
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
                          user.email ?? 'defaultUserEmail@example.com',
                          product.email,
                          product.productID,
                          product.orderID,
                        );

                        if (paymentUrl != null) {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentWebView(sandboxUrl: paymentUrl),
                            ),
                          );

                          if (result == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Pago exitoso')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error al iniciar el pago')),
                          );
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}