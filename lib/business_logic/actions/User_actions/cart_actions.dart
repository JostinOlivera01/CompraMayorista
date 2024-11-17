import 'package:test01/business_logic/models/cart_model.dart';
import 'package:test01/business_logic/service/cartService.dart';

class CartActions {
  final CartService _cartService;

  CartActions(this._cartService);

  // Agregar un carrito a Firestore
  Future<bool> addToCart(CartModel cart) async {
    try {
      return await _cartService.addToCart(cart);
    } catch (e) {
      print('Error en CartActions - addToCart: $e');
      throw Exception(e);
    }
  }

  // Obtener carritos por email del comprador
  Future<List<CartModel>> getCartsByEmail(String buyerEmail) async {
    try {
      print("JOSTIN1");

      return await _cartService.getCartsByEmail(buyerEmail);
    } catch (e) {
      print('Error en CartActions - getCartsByEmail: $e');
      throw Exception(e);
    }
  }

  // Actualizar carrito por cartId
  Future<bool> updateCart(String cartId, Map<String, dynamic> updatedData) async {
    try {
      return await _cartService.updateCart(cartId, updatedData);
    } catch (e) {
      print('Error en CartActions - updateCart: $e');
      throw Exception(e);
    }
  }

  // Eliminar un carrito por cartId
  Future<bool> deleteCart(String cartId) async {
    try {
      return await _cartService.deleteCart(cartId);
    } catch (e) {
      print('Error en CartActions - deleteCart: $e');
      throw Exception(e);
    }
  }
}
