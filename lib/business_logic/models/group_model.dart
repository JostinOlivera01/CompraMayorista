import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/members_model.dart';

class GroupModel {
  final String groupId;
  final String productId;
  final String adId; // Campo para adId
  final DateTime deadline;
  final int maxGroupSize;
  final int stockLimit;
  final int minGroupPurchase;
  final double productPrice;
  final String productName;
  final String description;
  final String? imgUrl; // Nuevo campo para URL de imagen
  List<IntegranteModel> integrantes; // Lista de integrantes

  GroupModel({
    required this.groupId,
    required this.productId,
    required this.adId,
    required this.deadline,
    required this.maxGroupSize,
    required this.stockLimit,
    required this.minGroupPurchase,
    required this.productPrice,
    required this.productName,
    required this.description,
    this.imgUrl, // Inicializamos el nuevo campo
    this.integrantes = const [], // Inicializamos la lista como vacía
  });

  // Método para convertir el modelo a un mapa para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'groupId': groupId,
      'productId': productId,
      'adId': adId,
      'deadline': deadline,
      'maxGroupSize': maxGroupSize,
      'stockLimit': stockLimit,
      'minGroupPurchase': minGroupPurchase,
      'productPrice': productPrice,
      'productName': productName,
      'description': description,
      'imgUrl': imgUrl, // Guardar el nuevo campo en Firestore
      // No guardamos los integrantes aquí; son una subcolección separada
    };
  }

  // Factory para convertir datos de Firestore en una instancia de GroupModel
  factory GroupModel.fromFirestore(Map<String, dynamic> data) {
    return GroupModel(
      groupId: data['groupId'] ?? '',
      productId: data['productId'] ?? '',
      adId: data['adId'] ?? '',
      deadline: (data['deadline'] as Timestamp?)?.toDate() ?? DateTime.now(),
      maxGroupSize: data['maxGroupSize'] ?? 0,
      stockLimit: data['stockLimit'] ?? 0,
      minGroupPurchase: data['minGroupPurchase'] ?? 0,
      productPrice: (data['productPrice'] != null ? (data['productPrice'] as num).toDouble() : 0.0),
      productName: data['productName'] ?? '',
      description: data['description'] ?? '',
      imgUrl: data['imgUrl'], // Extraer el nuevo campo desde Firestore
    );
  }

  // Método para agregar la lista de integrantes
  GroupModel addIntegrantes(List<IntegranteModel> integrantes) {
    return GroupModel(
      groupId: groupId,
      productId: productId,
      adId: adId,
      deadline: deadline,
      maxGroupSize: maxGroupSize,
      stockLimit: stockLimit,
      minGroupPurchase: minGroupPurchase,
      productPrice: productPrice,
      productName: productName,
      description: description,
      imgUrl: imgUrl, // Mantener el valor actual del campo
      integrantes: integrantes,
    );
  }
}
