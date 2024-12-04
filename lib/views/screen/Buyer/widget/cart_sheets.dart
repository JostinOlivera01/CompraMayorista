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
  Future<void> _loadCarts() async {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    await cartViewModel.fetchCartsByEmail(widget.buyerEmail);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UsuarioViewModel>(context);
    final orders = Provider.of<OrdersViewmodel>(context);

    return FutureBuilder(
      future: _loadCarts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar el carrito'));
        } else {
          final cartViewModel = Provider.of<CartViewModel>(context);
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Carrito de Compras',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                cartViewModel.carts.isEmpty
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
                                  cartItem.ImgUrl,
                                );

                                if (paymentUrl != null) {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PaymentWebView(
                                        sandboxUrl: paymentUrl,
                                        cartItem: cartItem,
                                      ),
                                    ),
                                  );

                                  // Verifica si se necesita recargar después del pago
                                  if (result == 'reload') {
                                    setState(() {}); // Fuerza reconstrucción y recarga
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Error al iniciar el pago')),
                                  );
                                }
                              },
                              child: CartCard(
                                cartItem: cartItem,
                                onDelete: () async {
                                  await cartViewModel.deleteCart(cartItem.cartId);
                                  setState(() {}); // Actualiza el estado después de eliminar
                                },
                                onUpdate: (newData) async {
                                  await cartViewModel.updateCart(
                                      cartItem.cartId, newData);
                                  setState(() {}); // Actualiza el estado después de actualizar
                                },
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          );
        }
      },
    );
  }
}
