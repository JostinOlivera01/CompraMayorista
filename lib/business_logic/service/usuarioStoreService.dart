import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/products_model.dart';
import 'package:test01/business_logic/models/usuario_model.dart';

class UsuarioStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserStoreModel user) async {
    print("JOSTIN");
    await _firestore.collection('Usuarios').doc(user.userID).set(user.toFirestore());
  }

  Future<UserStoreModel?> getUserByID(String userID) async {
    DocumentSnapshot doc = await _firestore.collection('Usuarios').doc(userID).get();
    if (doc.exists) {
      return UserStoreModel.fromFirestore(doc);
    }
    return null;
  }

  Future<void> createProducto(ProductModel product) async {
    await _firestore.collection('Productos').doc(product.name).set(product.toFirestore());
  }




}
