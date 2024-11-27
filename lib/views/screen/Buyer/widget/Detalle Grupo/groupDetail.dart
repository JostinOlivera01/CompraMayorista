import 'package:flutter/material.dart';

class GroupDetailWidget extends StatelessWidget {
  final String groupName;
  final int remainingQuantity;
  final String status;
  final List<String> participantImages;

  const GroupDetailWidget({
    super.key,
    required this.groupName,
    required this.remainingQuantity,
    required this.status,
    required this.participantImages,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título con el nombre del grupo y el número de integrantes
        Text(
          'Usuarios en Grupo (${participantImages.length})',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        // Mostramos las imágenes de los integrantes
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: participantImages.map((imageUrl) {
            return CircleAvatar(
              backgroundImage: NetworkImage(imageUrl), // Usamos la imagen predeterminada
              radius: 20,
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        // Información adicional del grupo
        Text('Cantidad Restante: $remainingQuantity'),
        Text(
          'Stock Restante: $status',
          style: TextStyle(
            color: status.toUpperCase() == 'ABIERTO'
                ? Colors.green
                : const Color.fromARGB(255, 64, 207, 85),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
