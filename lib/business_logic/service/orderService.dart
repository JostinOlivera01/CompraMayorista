import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/orders_model.dart';

class OrderStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<List<OrderModel>> getIndividualProducts(String email) async {
    QuerySnapshot snapshot = await _firestore.collection('Carrito').doc(email).collection('Individuales').get();
    //QuerySnapshot snapshot = await _firestore.collection('Ordenes').get();
      
    return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<List<OrderModel>> getGroupProducts(String email) async {
    QuerySnapshot snapshot = await _firestore.collection('Carrito').doc(email).collection('Grupales').get();
    return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
  }


// Obtener productos filtrados por el email del comprador desde Firestore
Future<List<OrderModel>> getPaymentedProducts(String emailComprador) async {
  QuerySnapshot snapshot = await _firestore
      .collection('Orden de Compra')
      .where('email_comprador', isEqualTo: emailComprador)
      .get();

  return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
}





  Future<void> createOrder(OrderModel orders) async {
      // Crea un nuevo documento sin guardar aún en Firestore y obtiene su ID
    DocumentReference cartDocRef = _firestore
        .collection('Carrito')
        .doc(orders.email)
        .collection('Individuales')
        .doc(); // Firestore generará el ID aquí

    // Genera el mapa de datos a partir de `orders` y agrega el ID generado en `idDeCarrito`
    final cartData = orders.toFirestore();
    cartData['orderID'] = cartDocRef.id;
    // Guarda el documento con el ID generado y los datos del carrito
    await cartDocRef.set(cartData);
  }



  





} 