import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String productName;
  final String productImageUrl;
  final double price;
  final String status; // Estado de la orden
  final DateTime creationDate; // Fecha de creación de la orden
  final VoidCallback onTap; // Callback para manejar el tap

  OrderCard({
    required this.productName,
    required this.productImageUrl,
    required this.price,
    required this.status,
    required this.creationDate,
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

              // Nombre del producto
              Text(
                productName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Precio y estado
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
                    status, // Muestra el estado de la orden
                    style: TextStyle(
                      fontSize: 14,
                      color: status == 'Pagado' ? Colors.green : Colors.red, // Color basado en el estado
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Fecha de creación de la orden
              Text(
                'Fecha de Creación: ${creationDate.toLocal().toString().split(' ')[0]}', // Formato simple de fecha
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
