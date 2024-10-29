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
  // Generar un nuevo ID para el documento
  DocumentReference newProductRef = _firestore.collection('Productos').doc();
  // Crear un nuevo objeto de producto que incluya el id_producto
  final productData = product.toFirestore();
  productData['productID'] = newProductRef.id; // Asignar el ID generado al campo id_producto
  // Guardar el documento en Firestore
  await newProductRef.set(productData);
  }




}
