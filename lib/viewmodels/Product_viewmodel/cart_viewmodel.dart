import 'package:flutter/material.dart';
import 'package:test01/business_logic/actions/User_actions/cart_actions.dart';
import 'package:test01/business_logic/models/cart_model.dart';

class CartViewModel extends ChangeNotifier {
  final CartActions _cartActions;
  List<CartModel> carts = [];
  bool isLoading = false;

  CartViewModel(this._cartActions);

  // Método para agregar un carrito
  Future<void> addCart(CartModel cart) async {
    try {
      isLoading = true;
      bool success = await _cartActions.addToCart(cart);
      
      notifyListeners();
      if (success) {
        carts.add(cart);
        notifyListeners();
      }
    } catch (e) {
      print('Error en CartViewModel - addCart: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Método para obtener carritos por email del comprador
  Future<void> fetchCartsByEmail(String buyerEmail) async {
    try {
      isLoading = true;
      carts = await _cartActions.getCartsByEmail(buyerEmail); // Se obtiene la lista de carritos
      notifyListeners();
    } catch (e) {
      print('Error en CartViewModel - fetchCartsByEmail: $e');
      carts = [];
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }








  // Método para actualizar un carrito
  Future<void> updateCart(String cartId, Map<String, dynamic> updatedData) async {
    try {
      isLoading = true;
      notifyListeners();

      bool success = await _cartActions.updateCart(cartId, updatedData);
      if (success) {
        int index = carts.indexWhere((cart) => cart.cartId == cartId);
        if (index != -1) {
          carts[index] = CartModel(
            cartId: cartId,
            adId: updatedData['adId'] ?? carts[index].adId,
            groupId: updatedData['groupId'] ?? carts[index].groupId,
            requestedStock: updatedData['requestedStock'] ?? carts[index].requestedStock,
            Name: updatedData['Name'] ?? carts[index].Name,
            buyerEmail: updatedData['buyerEmail'] ?? carts[index].buyerEmail,
            amountToPay: updatedData['totalPrice'] ?? carts[index].amountToPay,
            directPurchaseId: updatedData['directPurchaseId'] ?? carts[index].directPurchaseId, 
            providerId: 'cdscds',
            ImgUrl: updatedData['ImgUrl']
          );
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error en CartViewModel - updateCart: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Método para eliminar un carrito
  Future<void> deleteCart(String cartId) async {
    try {
      isLoading = true;
      notifyListeners();

      bool success = await _cartActions.deleteCart(cartId);
      if (success) {
        carts.removeWhere((cart) => cart.cartId == cartId);
        notifyListeners();
      }
    } catch (e) {
      print('Error en CartViewModel - deleteCart: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
