import 'package:http/http.dart' as http;
import 'dart:convert';

class MercadoPagoService {
  // URL de la API de Mercado Pago
  final String backendUrl = 'https://createpreferences-dy3mehaxpq-uc.a.run.app';

  // Token de autenticación de Mercado Pago (actualiza con tu propio token si es necesario)
  final String accessToken = 'TEST-1922698037737235-101718-86b39d158359494d0c84eb4e03d16cf4-257537041';

  Future<String> createPreference({required String title, required int quantity, required int unitPrice, required String emailComprador, required String emailVendedor, required String productID, required String orderID}) async {
    // Petición POST a la API de Mercado Pago

    int quantity1 = quantity;
    int unitPrice1 = unitPrice;
    final response = await http.post(
      Uri.parse(backendUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
      "title": title,
      "quantity": quantity,
      "unit_price": unitPrice,
      "currency_id": "CLP",
       "emailC": emailComprador,
        "emailP": emailVendedor,
      "productID": emailVendedor,
      "orderID":orderID
      }),
    );

    print(response.body);
    print("Dsadsa");
    if (response.statusCode == 201 || response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String preferenceUrl = data['url']; // URL para el checkout


      return preferenceUrl; // Devuelve la URL de la preferencia creada
    } else {
      print('Error ${response.statusCode}: ${response.body}');
      return 'dsd';
    }
  }
}
