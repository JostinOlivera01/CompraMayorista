import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productID;
  final String providerID;
  final String name;
  final String description;
  final double price;
  final double? groupPrice;  // Si admite compra grupal
  final int? stock;
  final String? category;
  final String? imageURL;
  final bool groupEnabled;
  final int? groupThreshold;  // Mínimo de compradores para activar compra grupal
  final DateTime? createdAt;

  ProductModel({
    required this.productID,
    required this.providerID,
    required this.name,
    required this.description,
    required this.price,
    this.groupPrice,
    this.stock,
    this.category,
    this.imageURL,
    required this.groupEnabled,
    this.groupThreshold,
    this.createdAt,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'productID': productID,
      'providerID': providerID,
      'name': name,
      'description': description,
      'price': price,
      'groupPrice': groupPrice,
      'stock': stock,
      'category': category,
      'imageURL': imageURL,
      'groupEnabled': groupEnabled,
      'groupThreshold': groupThreshold,
      'createdAt': createdAt,
    };
  }

factory ProductModel.fromFirestore(Map<String, dynamic> data) {
  return ProductModel(
    productID: data['productID'] ?? '', // Asigna un valor por defecto si es null
    providerID: data['providerID'] ?? '',
    name: data['name'] ?? '',
    description: data['description'] ?? '',
    price: (data['price'] as num?)?.toDouble() ?? 0.0, // Si el valor es null, asigna 0.0
    groupPrice: (data['groupPrice'] as num?)?.toDouble(), // Manejo de nulo opcional
    stock: data['stock'] ?? 0, // Valor por defecto si no hay stock
    category: data['category'] ?? '', // Manejo de null para categorías
    imageURL: data['imageURL'] ?? '', // Maneja la imagen del producto
    groupEnabled: data['groupEnabled'] ?? false, // Valor por defecto para booleanos
    groupThreshold: data['groupThreshold'] ?? 0, // Valor por defecto si es null
    createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(), // Manejo de timestamps nulos
  );
}

}
