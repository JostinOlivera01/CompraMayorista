import 'package:flutter/material.dart';
import 'package:test01/business_logic/actions/User_actions/cart_actions.dart';
import 'package:test01/business_logic/models/cart_model.dart';

class CartViewModel extends ChangeNotifier {
  final CartActions _cartActions;
  List<CartModel> carts = [];
  bool isLoading = false;

  CartViewModel(this._cartActions);

  // Método para verificar si un carrito existe
  Future<bool> doesCartExist(String cartId) async {
    try {
      isLoading = true;
      bool exists = await _cartActions.doesCartExist(cartId);
      return exists;
    } catch (e) {
      print('Error en CartViewModel - doesCartExist: $e');
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Método para agregar un carrito
  Future<void> addCart(CartModel cart) async {
    try {
      isLoading = true;
      bool success = await _cartActions.addToCart(cart);
      
      if (success) {
        carts.add(cart);
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
      carts = await _cartActions.getCartsByEmail(buyerEmail);
    } catch (e) {
      print('Error en CartViewModel - fetchCartsByEmail: $e');
      carts = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Método para actualizar un carrito
  Future<void> updateCart(String cartId, Map<String, dynamic> updatedData) async {
    try {
      isLoading = true;
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
            providerId: updatedData['providerId'] ?? carts[index].providerId,
            ImgUrl: updatedData['ImgUrl'] ?? carts[index].ImgUrl,
          );
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
      bool success = await _cartActions.deleteCart(cartId);

      if (success) {
        carts.removeWhere((cart) => cart.cartId == cartId);
      }
    } catch (e) {
      print('Error en CartViewModel - deleteCart: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
