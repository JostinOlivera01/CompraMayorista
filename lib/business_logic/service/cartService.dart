import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/cart_model.dart';

class CartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Agregar un nuevo carrito a Firestore
  Future<bool> addToCart(CartModel cart) async {
    try {
      DocumentReference cartRef = await _firestore.collection('Carts').add({
        'adId': cart.adId,
        'groupId': cart.groupId,
        'requestedStock': cart.requestedStock,
        'Name': cart.Name,
        'buyerEmail': cart.buyerEmail,
        'amountToPay': cart.amountToPay,
        'directPurchaseId': cart.directPurchaseId,
        'providerId': cart.providerId,
        'ImgUrl': cart.ImgUrl,
      });

      // Guardar el ID generado en Firestore
      await cartRef.update({'cartId': cartRef.id});
      return true;
    } catch (e) {
      print('Error adding to cart: $e');
      return false;
    }
  }

  // Obtener carritos específicos por email del comprador
  Future<List<CartModel>> getCartsByEmail(String buyerEmail) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Carts')
          .where('buyerEmail', isEqualTo: buyerEmail)
          .get();

      return snapshot.docs
          .map((doc) => CartModel.fromFirestore(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching carts for buyer email $buyerEmail: $e');
      return [];
    }
  }

  // Actualizar campos específicos en un carrito
  Future<bool> updateCart(String cartId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('Carts').doc(cartId).update(updatedData);
      return true;
    } catch (e) {
      print('Error updating cart: $e');
      return false;
    }
  }

  // Eliminar un carrito de Firestore
  Future<bool> deleteCart(String cartId) async {
    try {
      await _firestore.collection('Carts').doc(cartId).delete();
      return true;
    } catch (e) {
      print('Error deleting cart: $e');
      return false;
    }
  }

  // Verificar si un carrito existe en la colección por su cartId
  Future<bool> doesCartExist(String cartId) async {
    try {
      DocumentSnapshot cartDoc = await _firestore.collection('Carts').doc(cartId).get();

      // Verificar si el documento existe
      if (cartDoc.exists) {
        print('Cart with ID $cartId exists.');
        return true;
      } else {
        print('Cart with ID $cartId does not exist.');
        return false;
      }
    } catch (e) {
      print('Error checking if cart exists: $e');
      return false;
    }
  }
}
