import 'package:test01/business_logic/actions/User_actions/product_actions.dart';
import 'package:test01/business_logic/actions/User_actions/purchaseOrder_actions.dart';
import 'package:test01/business_logic/models/orders_model.dart';
import 'package:test01/business_logic/models/products_model.dart';
import 'package:flutter/material.dart';

class OrdersViewmodel extends ChangeNotifier {
  final OrderActions _orderActions;

  OrdersViewmodel(this._orderActions);

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


  Future<void> CreateOrderUser(String orderID ,String email,String productID,String providerID,String name,String description,double price,int stock,bool groupEnabled, String status) async {
    OrderModel newOrderUser = OrderModel(orderID: orderID,
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
