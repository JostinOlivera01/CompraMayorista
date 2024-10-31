import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productImageUrl;
  final String providerImageUrl;
  final double price;
  final int stock;
  final double rating;
  final VoidCallback onTap; // Agregamos esta propiedad para el callback

  const ProductCard({super.key, 
    required this.productName,
    required this.productImageUrl,
    required this.providerImageUrl,
    required this.price,
    required this.stock,
    required this.rating,
    required this.onTap, // Añadimos el onTap al constructor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Asignamos el onTap para detectar el clic
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
                  // Foto circular del proveedor
                  CircleAvatar(
                    backgroundImage: NetworkImage(providerImageUrl),
                    radius: 20,
                  ),
                  const SizedBox(width: 10),

                  // Nombre del producto
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

              // Precio y stock
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'Stock: $stock',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Clasificación en estrellas
              Row(
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 20,
                    );
                  }),
                  const SizedBox(width: 10),
                  Text(
                    rating.toStringAsFixed(1),
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
