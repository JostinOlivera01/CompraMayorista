
 import 'package:test01/business_logic/service/mercadoPagoService.dart';

class OrderPaymentAction {
  final MercadoPagoService _mercadoPagoService;

  OrderPaymentAction(this._mercadoPagoService);

  Future<String> createPaymentPreference({
    required String productName,
    required int quantity,
    required int price,
    required String emailComprador,
    required String emailVendedor,
    required String productID,
    required String orderID

  }) async {
    return await _mercadoPagoService.createPreference(
      title: productName,
      quantity: quantity,
      unitPrice: price,
      emailComprador: emailComprador,
      emailVendedor: emailVendedor,
      productID: productID,
      orderID: orderID
    );
  }
}
