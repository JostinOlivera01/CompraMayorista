import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/products_model.dart';

class ProductStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener todos los productos desde Firestore
  Future<List<ProductModel>> getAllProducts() async {
    QuerySnapshot snapshot = await _firestore.collection('Productos').get();
    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
  }
}