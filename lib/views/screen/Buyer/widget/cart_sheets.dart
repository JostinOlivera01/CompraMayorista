import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/Pagos_viewmdel/Orders_viewmodel.dart';
import 'package:test01/viewmodels/Product_viewmodel/cart_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Buyer/paymentMercado_screen.dart';
import 'package:test01/views/screen/Buyer/widget/card_cart.dart';

class CartSideSheet extends StatefulWidget {
  final String buyerEmail;

  const CartSideSheet({super.key, required this.buyerEmail});

  @override
  _CartSideSheetState createState() => _CartSideSheetState();
}

class _CartSideSheetState extends State<CartSideSheet> {
  @override
  void initState() {
    super.initState();
    _loadCarts();
  }

  Future<void> _loadCarts() async {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    await cartViewModel.fetchCartsByEmail(widget.buyerEmail);
  }

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    final user = Provider.of<UsuarioViewModel>(context);
    final orders = Provider.of<OrdersViewmodel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Título del Carrito
          const Text(
            'Carrito de Compras',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Lista de productos en el carrito
          cartViewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : cartViewModel.carts.isEmpty
                  ? const Center(child: Text('El carrito está vacío'))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: cartViewModel.carts.length,
                        itemBuilder: (context, index) {
                          final cartItem = cartViewModel.carts[index];
                          return GestureDetector(
                            onTap: () async {
                              final paymentUrl = await orders.initiatePayment(
                                cartItem.Name,
                                cartItem.requestedStock,
                                cartItem.amountToPay,
                                user.email ?? 'defaultUserEmail@example.com',
                                cartItem.providerId,
                                cartItem.providerId,
                                cartItem.cartId,
                                cartItem.ImgUrl

                              );

                              if (paymentUrl != null) {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentWebView(sandboxUrl: paymentUrl,cartItem: cartItem),
                                    // builder: (context) => InvoicePreviewScreen(),
                                  ),
                                );

                                if (result == 'success') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Pago exitoso')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Error al procesar el pago')),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Error al iniciar el pago')),
                                );
                              }
                            },
                            child: CartCard(
                              cartItem: cartItem,
                              onDelete: () => cartViewModel.deleteCart(cartItem.cartId),
                              onUpdate: (newData) => cartViewModel.updateCart(cartItem.cartId, newData),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
