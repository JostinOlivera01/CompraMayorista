import 'package:cloud_firestore/cloud_firestore.dart';

class Ad {
  final String? id; // Campo para almacenar el ID del documento
  final String productName;
  final String description;
  final String category;
  final DateTime publicationDate;
  final int publishedStock;
  final String publicationType;
  final int minimumPurchase;
  final int minimumStock;
  final double? precioProduct;
  final String status; 
  final String emailVendedor;

  Ad({
     this.id, // Nuevo campo ID
    required this.productName,
    required this.description,
    required this.category,
    required this.publicationDate,
    required this.publishedStock,
    required this.publicationType,
    required this.minimumPurchase,
    required this.minimumStock,
    required this.status,
    required this.emailVendedor,
    required this.precioProduct,
  });

  // Factory method para crear una instancia de Ad desde un documento Firestore
  factory Ad.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Ad(
      id: doc.id, // Asignar el ID del documento Firestore
      productName: data['productName'],
      description: data['description'],
      category: data['category'],
      publicationDate: (data['publicationDate'] as Timestamp).toDate(),
      publishedStock: data['publishedStock'],
      publicationType: data['publicationType'],
      minimumPurchase: data['minimumPurchase'],
      minimumStock: data['minimumStock'],
      status: data['status'],
      emailVendedor: data['emailVendedor'],
      precioProduct: data['precioProduct'],
    );
  }

  // Método para convertir una instancia de Ad a un documento Firestore
  Map<String, dynamic> toDocument() {
    return {
      'productName': productName,
      'description': description,
      'category': category,
      'publicationDate': Timestamp.fromDate(publicationDate),
      'publishedStock': publishedStock,
      'publicationType': publicationType,
      'minimumPurchase': minimumPurchase,
      'minimumStock': minimumStock,
      'status': status,
      'emailVendedor': emailVendedor,
      'precioProduct': precioProduct,
    };
  }
}
