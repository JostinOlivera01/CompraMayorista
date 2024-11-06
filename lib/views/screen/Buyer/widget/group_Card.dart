import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GroupProductCard extends StatelessWidget {
  final String groupId;
  final String productId;
  final String productName;
  final String productImageUrl;
  final String providerImageUrl;
  final double productPrice;
  final DateTime deadline;
  final int maxGroupSize;
  final int stockLimit;
  final int minGroupPurchase;
  final String description;
  final VoidCallback onTap;

  const GroupProductCard({
    super.key,
    required this.groupId,
    required this.productId,
    required this.productName,
    required this.productImageUrl,
    required this.providerImageUrl,
    required this.productPrice,
    required this.deadline,
    required this.maxGroupSize,
    required this.stockLimit,
    required this.minGroupPurchase,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDeadline = DateFormat('dd/MM/yyyy').format(deadline);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del producto
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  productImageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),

              // Foto del proveedor y nombre del producto
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(providerImageUrl),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Precio del producto y límite de stock
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${productPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'Stock: $stockLimit',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Detalles del grupo
              Text(
                'Compra grupal habilitada',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
              Text(
                'Umbral mínimo: $minGroupPurchase compradores',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Tamaño máximo del grupo: $maxGroupSize',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Fecha límite: $formattedDeadline',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),

              // Descripción del producto
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
