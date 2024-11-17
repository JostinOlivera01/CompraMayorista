import 'package:flutter/material.dart';
import 'package:test01/business_logic/models/ad_model.dart';

class IndividualPurchaseBottomSheet extends StatelessWidget {
  final Ad ad;

  const IndividualPurchaseBottomSheet({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Compra Individual',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Producto: ${ad.productName}',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'Precio: \$${ad.precioProduct?.toStringAsFixed(0)}',
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            'Stock disponible: ${ad.publishedStock}',
            style: const TextStyle(fontSize: 16),
          ),
          ElevatedButton(
            onPressed: () {
              // Acción para proceder con la compra
              Navigator.pop(context);
              // Lógica adicional de compra individual
            },
            child: const Text('Comprar'),
          ),
        ],
      ),
    );
  }
}
