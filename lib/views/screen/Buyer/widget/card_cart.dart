import 'package:flutter/material.dart';
import 'package:test01/business_logic/models/cart_model.dart';

class CartCard extends StatelessWidget {
  final CartModel cartItem;
  final VoidCallback onDelete;
  final Function(Map<String, dynamic>) onUpdate;

  const CartCard({
    super.key,
    required this.cartItem,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Imagen del producto
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(cartItem.ImgUrl), // URL de la imagen
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.Name, // Nombre del producto
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Cantidad: ${cartItem.requestedStock}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Total: \$${cartItem.amountToPay.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14, color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
