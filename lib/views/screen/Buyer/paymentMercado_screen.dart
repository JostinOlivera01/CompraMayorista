import 'dart:async'; // Importa para usar Completer
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:provider/provider.dart';
import 'package:test01/business_logic/models/cart_model.dart';
import 'package:test01/viewmodels/Product_viewmodel/cart_viewmodel.dart';

class PaymentWebView extends StatefulWidget {
  final String sandboxUrl;
  final CartModel cartItem;

  const PaymentWebView({
    Key? key,
    required this.sandboxUrl,
    required this.cartItem,
  }) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> with WidgetsBindingObserver {
  bool isCartPending = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Agrega el observador
    _checkCartStatus(); // Verifica el estado del carrito al cargar
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Elimina el observador
    super.dispose();
  }

  // Detecta cambios en el estado del ciclo de vida de la app
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Cuando la app vuelve a primer plano, verifica el estado del carrito
      _checkCartStatus();
    }
  }

  // Verifica el estado del carrito en el ViewModel
  Future<void> _checkCartStatus() async {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    bool exists = await cartViewModel.doesCartExist(widget.cartItem.cartId!);
    setState(() {
      isCartPending = exists; // Si existe, sigue pendiente; si no, está pagado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context, 'reload'); // Indica que se debe recargar
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
                isCartPending ? 'Estado: Pendiente de Pago' : 'Estado: PAGADO',
                style: TextStyle(
                  color: isCartPending ? Colors.orangeAccent : Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Información del Producto'),
            _buildInfoBox(
              children: [
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(widget.cartItem.ImgUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Producto: ${widget.cartItem.Name}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Cantidad: ${widget.cartItem.requestedStock}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'Total: \$${widget.cartItem.amountToPay.toStringAsFixed(2)}',
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
                Text('Correo Electrónico: ${widget.cartItem.buyerEmail}'),
                Text('ID Proveedor: ${widget.cartItem.providerId}'),
              ],
            ),
            const SizedBox(height: 30),
            if (isCartPending) // Mostrar el botón solo si el carrito está pendiente
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
                    await _handlePaymentFlow(); // Maneja el flujo de pago
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

  // Manejo del flujo de pago
  Future<void> _handlePaymentFlow() async {
    Uri uri = Uri.parse(widget.sandboxUrl);
    try {
      await launchUrl(
        uri,
        customTabsOptions: CustomTabsOptions(
          colorSchemes: CustomTabsColorSchemes.defaults(),
          urlBarHidingEnabled: true,
          shareState: CustomTabsShareState.browserDefault,
          showTitle: true,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al abrir la URL')),
      );
    }
  }
}
