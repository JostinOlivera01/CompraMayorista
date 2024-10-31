import 'package:test01/business_logic/actions/User_actions/product_actions.dart';
import 'package:test01/business_logic/models/products_model.dart';
import 'package:flutter/material.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductActions _productActions;

  ProductViewModel(this._productActions);

  // Método para obtener productos desde Firestore
  Future<List<ProductModel>> fetchProducts() async {
    try {
      return await _productActions.getAllProducts();
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  // Método para obtener productos desde Firestore INVENTARIO PROVEEDOR
  Future<List<ProductModel>> fetchProductsInventary(String email, String codproducto) async {
    try {
      return await _productActions.fetchProductsInventary(email,codproducto);
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }


    // Método para obtener productos desde Firestore INVENTARIO PROVEEDOR TODO
  Future<List<ProductModel>> fetchProductsInventaryAll(String email) async {
    try {
      return await _productActions.fetchProductsInventaryAll(email);
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }



}
