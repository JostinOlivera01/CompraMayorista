import 'package:flutter/material.dart';

class DirectPurchaseForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Publicar Producto como Compra Directa', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // Aquí puedes añadir los campos que necesites para la compra directa
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implementar lógica para publicar anuncio de compra directa
            },
            child: Text('Publicar'),
          ),
        ],
      ),
    );
  }
}
