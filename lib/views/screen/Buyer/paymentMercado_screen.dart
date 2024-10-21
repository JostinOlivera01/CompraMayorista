import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PaymentWebView extends StatefulWidget {
  final String sandboxUrl;

  const PaymentWebView({Key? key, required this.sandboxUrl}) : super(key: key);

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late InAppWebViewController _webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mercado Pago - Sandbox'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(),
        onWebViewCreated: (controller) {
          _webViewController = controller;
        },
        onLoadStart: (controller, url) {
          // Puedes manejar la carga inicial aquí
          print("Cargando URL: $url");
        },
        onLoadStop: (controller, url) async {
          // Puedes manejar el evento de cuando la carga se detiene
          print("Carga completa de la URL: $url");
        },
      ),
    );
  }
}
