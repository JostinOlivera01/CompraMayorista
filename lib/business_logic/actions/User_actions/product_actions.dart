import 'package:test01/business_logic/models/orders_model.dart';
import 'package:test01/business_logic/models/products_model.dart';
import 'package:test01/business_logic/service/productService.dart';


class ProductActions {
  final ProductStoreService _productStoreService;

  ProductActions(this._productStoreService);

  // Obtener todos los productos desde Firestore
  Future<List<ProductModel>> getAllProducts() async {
    try {
      return await _productStoreService.getAllProducts();
    } catch (e) {
      print('Error en ProductActions: $e');
      throw Exception( e);
    }
  }





}
