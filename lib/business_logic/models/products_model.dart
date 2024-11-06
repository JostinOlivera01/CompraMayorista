import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String productID;
  final String providerID;
  final String name;
  final String description;
  final double price;
  final double? groupPrice;
  final int? stock;
  final String? category;
  final String? imageURL;
  final bool groupEnabled;
  final int? groupThreshold;  
  final DateTime? createdAt;
  final int? minDirectPurchaseQuantity;  
  final int? minGroupPurchaseQuantity;    

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
    this.minDirectPurchaseQuantity,
    this.minGroupPurchaseQuantity,
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
      'minDirectPurchaseQuantity': minDirectPurchaseQuantity, // Nuevo campo
      'minGroupPurchaseQuantity': minGroupPurchaseQuantity,   // Nuevo campo
    };
  }

  factory ProductModel.fromFirestore(Map<String, dynamic> data) {
    return ProductModel(
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
      minDirectPurchaseQuantity: data['minDirectPurchaseQuantity'] ?? 1, // Valor por defecto
      minGroupPurchaseQuantity: data['minGroupPurchaseQuantity'] ?? 1,   // Valor por defecto
    );
  }
}

