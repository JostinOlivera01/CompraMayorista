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
        Text('Usuarios en $groupName', style: TextStyle(fontWeight: FontWeight.bold)),
        Row(
          children: participantImages.map((imageUrl) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://img.freepik.com/vector-premium/circulo-usuario-circulo-gradiente-azul_78370-4727.jpg?w=740'),
                radius: 15,
              ),
            );
          }).toList(),
        ),
        Text('Cantidad Restante: $remainingQuantity'),
        Text('Estado: $status', style: TextStyle(color: status == 'ABIERTO' ? Colors.green : Colors.red)),
        const Divider(),
      ],
    );
  }
}
