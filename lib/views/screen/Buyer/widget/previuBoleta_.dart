import 'package:flutter/material.dart';

class InvoicePreviewScreen extends StatelessWidget {
  const InvoicePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Orden de Compra N°624851',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Detalle de Compra',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Fecha recepción: 05-07-2023',
                    style: TextStyle(fontSize: 14)),
                Text('Folio: 32', style: TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Información Cliente'),
            _buildInfoBox(
              children: const [
                Text('Razón Social: Constructora Ingevec'),
                Text('RUT: 089853009'),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Detalle Retiro'),
            _buildInfoBox(
              children: const [
                Text('Dirección: Felipe Navarrete'),
                Text('Patente: SFKA23'),
                Text('Fecha Recepción: 05-01-2023 10:30am'),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Detalle Pedido'),
            _buildInfoBox(
              children: [
                Table(
                  border: TableBorder.all(color: Colors.grey),
                  columnWidths: const {
                    0: FlexColumnWidth(3),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(2),
                  },
                  children: [
                    _buildTableRow(
                      ['Nombre', 'Cantidad', 'Valor'],
                      isHeader: true,
                    ),
                    _buildTableRow(['Producto A', '2', '\$10,000']),
                    _buildTableRow(['Producto B', '1', '\$5,000']),
                    _buildTableRow(['Producto C', '3', '\$15,000']),
                  ],
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Total: \$30,000',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'NOTA: Lorem ipsum dolor sit amet',
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 20.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  // Acción para ver la boleta
                },
                child: const Text(
                  'Ver Boleta',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.blue,
      ),
    );
  }

  Widget _buildInfoBox({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  TableRow _buildTableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      children: cells.map((cell) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            cell,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        );
      }).toList(),
    );
  }
}
