import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:test01/business_logic/models/cart_model.dart';

class PaymentWebView extends StatelessWidget {
  final String sandboxUrl;
  final CartModel cartItem;

  const PaymentWebView({
    super.key,
    required this.sandboxUrl,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);  // Regresar a la pantalla anterior
          },
        ),
        title: const Text(
          'Resumen de Compra',
          style: TextStyle(fontSize: 16, color: Colors.white),
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
                'Estado: Pendiente de Pago',
                style: TextStyle(
                  color: Colors.orangeAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Información del Producto'),
            _buildInfoBox(
              children: [
                // Imagen del producto
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(cartItem.ImgUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Nombre del producto
                Text(
                  'Producto: ${cartItem.Name}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Cantidad: ${cartItem.requestedStock}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Total: \$${cartItem.amountToPay.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Información del Comprador'),
            _buildInfoBox(
              children: [
                Text('Correo Electrónico: ${cartItem.buyerEmail}'),
                Text('ID Proveedor: ${cartItem.providerId}'),
              ],
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 20.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  final result = await _launchURL(context, sandboxUrl);

                  print("dataa3233222");
                  print(result);
                  if (!result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Error al abrir la URL')),
                    );
                  }
                },
                child: const Text(
                  'Ir a Pagar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
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
      style: const TextStyle(
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

  Future<bool> _launchURL(BuildContext context, String url) async {
    try {
      Uri uri = Uri.parse(url);
      await launchUrl(
        uri,
        customTabsOptions: CustomTabsOptions(
          colorSchemes: CustomTabsColorSchemes.defaults(),
          urlBarHidingEnabled: true,
          shareState: CustomTabsShareState.browserDefault,
          showTitle: true,
        ),
      );
      print(uri);
      return true;
    } catch (e) {
      debugPrint('Error al abrir la URL: $e');
      return false;
    }
  }

  // Función que maneja la redirección según el estado del pago
  void _handleRedirect(BuildContext context, bool paymentSuccess) {

    print("dscdscds");
    print(paymentSuccess);
    if (paymentSuccess) {
      
      // Navegar a la pantalla de éxito
      context.go('/payment-success');
    } else {
      context.go('/payment-success');

    }
  }


}
