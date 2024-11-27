import 'package:flutter/material.dart';

class WithdrawalDetailsDrawer extends StatelessWidget {
  const WithdrawalDetailsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Purchase'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Abre el drawer lateral
          },
          child: const Text('Abrir Detalle de Retiro'),
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título centrado
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Detalle de Retiro',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const Divider(), // Línea divisoria opcional
            // Dirección ficticia
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Dirección de Retiro: Calle Falsa 123, Ciudad, País',
                style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              ),
            ),
            const SizedBox(height: 16), // Espaciado
            // Detalles del producto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Detalles del Producto:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Nombre: Producto de Ejemplo', style: TextStyle(fontSize: 14)),
                  Text('Cantidad: 3 unidades', style: TextStyle(fontSize: 14)),
                  Text('Precio: \$45.00', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            const Spacer(),
            // Código generado
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'CÓDIGO: ABC123XYZ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
