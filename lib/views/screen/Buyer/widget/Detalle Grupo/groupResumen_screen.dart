import 'package:flutter/material.dart';

class ResumenTabContent extends StatelessWidget {
  const ResumenTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del Producto
            Center(
              child: Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Imagen del Producto', style: TextStyle(color: Colors.black54)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Detalle de Compra
            _buildSectionTitle('Detalle de Compra'),
            const SizedBox(height: 8),
            _buildDetailRow('Nombre:', 'Coca-Cola 473ml'),
            _buildDetailRow('Unidades compradas:', '10'),
            const SizedBox(height: 16),
            _buildSectionDivider(),

            // Precio y Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Precio Unitario', style: TextStyle(color: Colors.grey[700])),
                    Text('\$1.000', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('TOTAL', style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold)),
                    Text('\$10.000', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Detalles del Proveedor
            const Divider(height: 32),
            _buildSectionTitle('Detalle del Proveedor'),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://img.freepik.com/vector-premium/circulo-usuario-circulo-gradiente-azul_78370-4727.jpg?w=740',
                  ),
                  radius: 30,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Nombre Distribuidora',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text('Razón Social: Nombre Distribuidora', style: TextStyle(color: Colors.black54)),
                    Text('Folio: 60', style: TextStyle(color: Colors.black54)),
                    Text('Núm empresa: 624849', style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ],
            ),
            const Divider(height: 32),

            // Detalle de Grupo
            _buildSectionTitle('Detalle de Grupo'),
            const SizedBox(height: 8),
            _buildDetailRow('Compra mínima:', '100 unidades'),
            _buildDetailRow('Stock límite:', '1000'),
            _buildDetailRow('Máximo participante:', '10'),
            const SizedBox(height: 16),

            // Botones de Acción
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton('Ver Boleta', Colors.purple),
                _buildActionButton('Abandonar Grupo', Colors.redAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey,
      ),
    );
  }

  Widget _buildSectionDivider() {
    return Divider(color: Colors.grey[300], thickness: 1);
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, Color color) {
    return ElevatedButton(
      onPressed: () {
        // Acción para el botón
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
