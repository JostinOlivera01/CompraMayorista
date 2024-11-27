import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/products_model.dart';

class OrderModel extends ProductModel {
  final String orderID; // ID de la orden de compra
  final String title; // ID del carrito asociado
  final String buyerEmail; // Email del comprador
  final String providerEmail; // Email del proveedor
  final int quantity; // Cantidad comprada
  final int unit_price; // Precio unitario del producto
  final String status; // Estado de la orden
  final DateTime orderCreationDate; // Fecha de creación de la orden
  @override
  final DateTime createdAt; // Fecha de creación en Firestore

  OrderModel({
    required this.orderID,
    required this.title,
    required this.buyerEmail,
    required this.providerEmail,
    required this.quantity,
    required this.unit_price,
    required super.productID,
    required super.providerID,
    required super.name,
    required super.description,
    required super.price,
    super.groupPrice,
    super.stock,
    super.category,
    super.imageURL,
    required super.groupEnabled,
    super.groupThreshold,
    required this.status,
    required this.orderCreationDate,
    required this.createdAt,
  }) : super(
          createdAt: createdAt, // Fecha de creación heredada del modelo base
        );

  // Método para convertir la orden a formato Firestore
  @override
  Map<String, dynamic> toFirestore() {
    return {
      'orderID': orderID,
      'title': title,
      'buyerEmail': buyerEmail,
      'providerEmail': providerEmail,
      'quantity': quantity,
      'unitPrice': unit_price,
      'status': status,
      'orderCreationDate': orderCreationDate,
      'createdAt': createdAt,
      ...super.toFirestore(), // Incluye los campos del modelo ProductModel
    };
  }

  // Método para crear una instancia de OrderModel desde Firestore
  factory OrderModel.fromFirestore(Map<String, dynamic> data) {
    return OrderModel(
      orderID: data['orderID'] ?? '',
      title: data['title'] ?? '',
      buyerEmail: data['buyerEmail'] ?? '',
      providerEmail: data['providerEmail'] ?? '',
      quantity: data['quantity'] ?? 0,
      unit_price: (data['unit_price']),
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
    );
  }
}
