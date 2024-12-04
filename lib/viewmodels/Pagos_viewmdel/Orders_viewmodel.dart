import 'package:test01/business_logic/actions/User_actions/mercadoPago_actions.dart';
import 'package:test01/business_logic/actions/User_actions/purchaseOrder_actions.dart';
import 'package:test01/business_logic/models/orders_model.dart';
import 'package:flutter/material.dart';

class OrdersViewmodel extends ChangeNotifier {
  final OrderActions _orderActions;

  final OrderPaymentAction _orderPaymentAction;


  OrdersViewmodel(this._orderActions, this._orderPaymentAction);



Future<String?> initiatePayment(String productName, int quantity, double price, String emailComprador, String emailVendedor, String productID, String orderID, String ImgUrl) async {
  try {
    // Convertir el precio de double a int
    int priceInt = price.toInt();

    print("Iniciando el proceso de pago para $productName, cantidad: $quantity, precio: $priceInt, $emailComprador $emailVendedor $productID $orderID ");

    final paymentUrl = await _orderPaymentAction.createPaymentPreference(
      productName: productName,
      quantity: quantity,
      price: priceInt, // Usar el precio convertido
      emailComprador: emailComprador,
      emailVendedor: emailVendedor,
      productID: productID,
      orderID: orderID,
      imgUrl: ImgUrl

    );

    notifyListeners();

    return paymentUrl;
  } catch (e) {
    print('Error en el proceso de pago: $e');
    return null;
  }
}



  // Método para obtener productos desde Firestore
  Future<List<OrderModel>> fetchPaymented(String email) async {
    try {
      print("ORDEN DE COMPRA $email");
      return await _orderActions.getPaymentedProducts(email);
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }


  // Método para obtener productos desde Firestore
  Future<List<OrderModel>> fetchOrderInv(String email) async {
    try {
      print("JOS $email");
      return await _orderActions.getIndividualOrder(email);
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  // Método para obtener productos desde Firestore
  Future<List<OrderModel>> fetchOrderGrp(String email) async {
    try {
      return await _orderActions.getGrupalOrder(email);
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }








}
