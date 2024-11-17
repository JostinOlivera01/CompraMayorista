import 'package:flutter/material.dart';

class ProviderDetailWidget extends StatelessWidget {
  final String name;
  final String socialReason;
  final int folio;
  final int companyNumber;
  final String profileImageUrl;

  const ProviderDetailWidget({
    super.key,
    required this.name,
    required this.socialReason,
    required this.folio,
    required this.companyNumber,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://img.freepik.com/vector-premium/circulo-usuario-circulo-gradiente-azul_78370-4727.jpg?w=740'),
              radius: 30,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Razón Social: $socialReason'),
                Text('Folio: $folio'),
                Text('Núm empresa: $companyNumber'),
              ],
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
