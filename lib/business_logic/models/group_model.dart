import 'package:cloud_firestore/cloud_firestore.dart';

class GroupModel {
  final String groupId;
  final String productId;
  final DateTime deadline;
  final int maxGroupSize;
  final int stockLimit;
  final int minGroupPurchase;
  final double productPrice;
  final String productName;
  final String description;

  GroupModel({
    required this.groupId,
    required this.productId,
    required this.deadline,
    required this.maxGroupSize,
    required this.stockLimit,
    required this.minGroupPurchase,
    required this.productPrice,
    required this.productName,
    required this.description,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'groupId': groupId,
      'productId': productId,
      'deadline': deadline,
      'maxGroupSize': maxGroupSize,
      'stockLimit': stockLimit,
      'minGroupPurchase': minGroupPurchase,
      'productPrice': productPrice,
      'productName': productName,
      'description': description,
    };
  }

factory GroupModel.fromFirestore(Map<String, dynamic> data) {
  return GroupModel(
    groupId: data['groupId'] ?? '',
    productId: data['productId'] ?? '',
deadline: (data['deadline'] as Timestamp?)?.toDate() ?? DateTime.now(),
    maxGroupSize: data['maxGroupSize'] ?? 0,
    stockLimit: data['stockLimit'] ?? 0,
    minGroupPurchase: data['minGroupPurchase'] ?? 0,
    productPrice: (data['productPrice'] != null ? (data['productPrice'] as num).toDouble() : 0.0),
    productName: data['productName'] ?? '',
    description: data['description'] ?? '',
  );
}

}
