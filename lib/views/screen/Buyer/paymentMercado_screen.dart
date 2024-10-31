import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';


class PaymentWebView extends StatelessWidget {
  final String sandboxUrl;

  const PaymentWebView({super.key, required this.sandboxUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mercado Pago - Sandbox'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('Abrir Mercado Pago Sandbox'),
          onPressed: () async {
            final result = await _launchURL(context, sandboxUrl);
            Navigator.pop(context, result ? 'success' : 'failure');
          },
        ),
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
      return true;
    } catch (e) {
      debugPrint('Error al abrir la URL: $e');
      return false;
    }
  }
}
