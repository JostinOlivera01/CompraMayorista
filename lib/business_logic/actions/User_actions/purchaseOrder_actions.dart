import 'package:test01/business_logic/models/orders_model.dart';
import 'package:test01/business_logic/service/orderService.dart';


class OrderActions {
  final OrderStoreService _orderStoreService;

  OrderActions(this._orderStoreService);

  //  Obtener HISTORIAL DE COMPRAS 
  Future<List<OrderModel>> getPaymentedProducts(String email) async {
    try {
      print("JOS 55");
      return await _orderStoreService.getPaymentedProducts(email);
    } catch (e) {
      print('Error en ProductActions: $e');
      throw Exception( e);
    }
  }


  // Obtener todos los productos desde Firestore
  Future<List<OrderModel>> getIndividualOrder(String email) async {
    try {
      print("JOS 55");
      return await _orderStoreService.getIndividualProducts(email);
    } catch (e) {
      print('Error en ProductActions: $e');
      throw Exception( e);
    }
  }

    // Obtener todos los productos desde Firestore
  Future<List<OrderModel>> getGrupalOrder(String email) async {
    try {
      return await _orderStoreService.getGroupProducts(email);
    } catch (e) {
      print('Error en ProductActions: $e');
      throw Exception( e);
    }
  }

    Future<void> createOrder(OrderModel order){
    return _orderStoreService.createOrder(order);
  }


}
