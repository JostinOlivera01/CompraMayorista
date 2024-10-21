import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/products_model.dart';

class OrderModel extends ProductModel {
  final String orderID;  // ID de la orden de compra
  final String status;  // Estado de la orden
  final DateTime? orderCreationDate;  // Fecha de creación de la orden
  final DateTime? paymentDate;  // Fecha de pago de la orden
  final DateTime? dueDate;  // Fecha de vencimiento de la orden
  final String email;

OrderModel({
  required this.orderID,
  required this.email,
  required String productID,
  required String providerID,
  required String name,
  required String description,
  required double price,
  double? groupPrice,
  int? stock,
  String? category,
  String? imageURL,
  required bool groupEnabled,
  int? groupThreshold,
  DateTime? createdAt,
  required this.status,
  this.orderCreationDate,
  this.paymentDate,
  this.dueDate,
}) : super(
        productID: productID,
        providerID: providerID,
        name: name,
        description: description,
        price: price,
        groupPrice: groupPrice,
        stock: stock,
        category: category,
        imageURL: imageURL,
        groupEnabled: groupEnabled,
        groupThreshold: groupThreshold,
        createdAt: createdAt ?? DateTime.now(),  // Fecha de creación por defecto
      ); 

  // Método para convertir la orden a formato Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'orderID': orderID,
      'status': status,
      'email':email,
      'orderCreationDate': orderCreationDate ?? DateTime.now(),
      'paymentDate': paymentDate ?? DateTime.now(),
      'dueDate': dueDate ?? DateTime.now(),
      ...super.toFirestore(),  // Incluye los campos del modelo ProductModel
    };
  }

  // Método para crear una instancia de OrderModel desde Firestore
  factory OrderModel.fromFirestore(Map<String, dynamic> data) {
    return OrderModel(
      orderID: data['orderID'] ?? '',
      email: data['email'] ?? '',
      productID: data['productID'] ?? '',
      providerID: data['providerID'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      groupPrice: (data['groupPrice'] as num?)?.toDouble(),
      stock: data['stock'] ?? 0,
      category: data['category'] ?? '',
      imageURL: data['imageURL'] ?? '',
      groupEnabled: data['groupEnabled'] ?? false,
      groupThreshold: data['groupThreshold'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: data['status'] ?? 'Pendiente', // Valor por defecto
      orderCreationDate: (data['orderCreationDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      paymentDate:(data['paymentDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      dueDate: (data['dueDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
