import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/orders_model.dart';

class OrderStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener todos los productos desde Firestore
  Future<List<OrderModel>> getAllProducts() async {
    QuerySnapshot snapshot = await _firestore.collection('Ordenes').get();
    return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
  }


  Future<List<OrderModel>> getIndividualProducts(String email) async {
          print("JOS $email");
    QuerySnapshot snapshot = await _firestore.collection('Ordenes').doc(email).collection('Individuales').get();
    //QuerySnapshot snapshot = await _firestore.collection('Ordenes').get();
      
    return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<List<OrderModel>> getGroupProducts(String email) async {
    QuerySnapshot snapshot = await _firestore.collection('Ordenes').doc(email).collection('Grupales').get();
    return snapshot.docs.map((doc) => OrderModel.fromFirestore(doc.data() as Map<String, dynamic>)).toList();
  }

    Future<void> createOrder(OrderModel orders) async {
    await _firestore.collection('Ordenes').doc(orders.email).collection('Individuales').doc(orders.name).set(orders.toFirestore());
  }





} 