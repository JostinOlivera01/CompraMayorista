import 'package:test01/business_logic/actions/User_actions/mercadoPago_actions.dart';
import 'package:test01/business_logic/actions/User_actions/purchaseOrder_actions.dart';
import 'package:test01/business_logic/models/orders_model.dart';
import 'package:flutter/material.dart';

class OrdersViewmodel extends ChangeNotifier {
  final OrderActions _orderActions;

  final OrderPaymentAction _orderPaymentAction;


  OrdersViewmodel(this._orderActions, this._orderPaymentAction);



Future<String?> initiatePayment(String productName, int quantity, double price, String emailComprador, String emailVendedor, String productID, String orderID) async {
  try {
    // Convertir el precio de double a int
    int priceInt = price.toInt();

    print("Iniciando el proceso de pago para $productName, cantidad: $quantity, precio: $priceInt");

    final paymentUrl = await _orderPaymentAction.createPaymentPreference(
      productName: productName,
      quantity: quantity,
      price: priceInt, // Usar el precio convertido
      emailComprador: emailComprador,
      emailVendedor: emailVendedor,
      productID: productID,
      orderID: orderID

    );

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

  //CREA ORDEN DE USUARIO SE DUPLICA DE COLLECION PRODUCTO A ORDEN
  Future<void> CreateOrderUser(String orderID ,String email,String productID,String providerID,String name,String description,double price,int stock,bool groupEnabled, String status) async {
    OrderModel newOrderUser = OrderModel(
  orderID: orderID,
     email: email, 
     productID: productID,
      providerID: providerID,
       name: name,
        description: description,
         price: price,
          stock: stock, 
          groupEnabled: groupEnabled,
           status: status);

    await _orderActions.createOrder(newOrderUser);
  }






}
