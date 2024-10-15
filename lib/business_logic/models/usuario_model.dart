import 'package:cloud_firestore/cloud_firestore.dart';

class UserStoreModel {
  final String userID;
  final String email;
  final String name;
  final String role;
  final DateTime registrationDate;
  final String? profilePhotoURL;

  UserStoreModel({
    required this.userID,
    required this.email,
    required this.name,
    required this.role,
    required this.registrationDate,
    this.profilePhotoURL,
  });

  factory UserStoreModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserStoreModel(
      userID: doc.id,
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      role: data['role'] ?? '',
      registrationDate: (data['registrationDate'] as Timestamp).toDate(),
      profilePhotoURL: data['profilePhotoURL'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'name': name,
      'role': role,
      'registrationDate': Timestamp.fromDate(registrationDate),
      'profilePhotoURL': profilePhotoURL,
    };
  }
}
