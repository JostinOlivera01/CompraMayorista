import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test01/business_logic/models/group_model.dart';

class GroupCard extends StatelessWidget {
  final GroupModel group;
  final String status; // Puedes definir el estado fuera del modelo si es necesario
  final List<String> members; // Lista de URLs de fotos de los miembros

  const GroupCard({
    super.key,
    required this.group,
    required this.status,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(
                  group.imgUrl ?? 'https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg'), // Imagen de ejemplo
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('\$${group.productPrice.toStringAsFixed(2)}'),
                  Text('Stock: ${group.stockLimit}'),
                  Text('Fecha: ${DateFormat('dd/MM/yyyy').format(group.deadline)}'),
                  Text('Estado: $status'),
                  const Text('Integrantes:'),
                  Row(
                    children: members.map((url) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(url),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }
}
