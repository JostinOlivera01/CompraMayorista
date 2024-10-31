import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/products_model.dart';

class ProductStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener todos los productos desde Firestore
  Future<List<ProductModel>> getAllProducts() async {
    QuerySnapshot snapshot = await _firestore.collection('Productos').get();
    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
  }



  Future<List<ProductModel>> getProductsInventoryAll(String emailProveedor) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('Productos')
          .where('providerID', isEqualTo: emailProveedor)
          .get();

      return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error obteniendo productos: $e');
      return []; // Retorna una lista vacía en caso de error
    }
  }


  // Obtener todos los productos desde Firestore
  Future<List<ProductModel>> getProductsInventory(String emailProveedor,String codproducto) async {
    try{
      QuerySnapshot snapshot = await _firestore
          .collection('Productos')
          .where('providerID', isEqualTo: emailProveedor) // Filtrar por el correo del proveedor
          .where('name', isEqualTo: codproducto) // Filtrar por el código de producto
          .get();
      return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error obteniendo productos: $e');
      return [];
    }
  }
}