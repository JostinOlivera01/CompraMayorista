import 'package:flutter/material.dart';
import 'package:test01/business_logic/models/products_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imageURL != null)
              Image.network(
                product.imageURL!,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 8),
            Text( 
              product.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('Descripción: ${product.description}'),
            Text('Precio: \$${product.price.toStringAsFixed(0)}'),
            if (product.groupEnabled && product.groupPrice != null)
              Text('Precio de grupo: \$${product.groupPrice!.toStringAsFixed(0)}'),
            Text('Stock disponible: ${product.stock ?? 'Sin información'}'),
            Text('Categoría: ${product.category ?? 'Sin categoría'}'),
            if (product.groupThreshold != null && product.groupThreshold! > 0)
              Text('Umbral de grupo: ${product.groupThreshold}'),
            if (product.minDirectPurchaseQuantity != null)
              Text('Compra mínima directa: ${product.minDirectPurchaseQuantity}'),
            if (product.minGroupPurchaseQuantity != null)
              Text('Compra mínima grupal: ${product.minGroupPurchaseQuantity}'),
          ],
        ),
      ),
    );
  }
}
