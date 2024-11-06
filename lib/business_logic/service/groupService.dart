import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/group_model.dart';

class GroupService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Obtener todos los grupos desde Firestore
  Future<List<GroupModel>> getAllGroups() async {
    QuerySnapshot snapshot = await _firestore.collection('Grupos de Compra').get();
    print(snapshot);
    return snapshot.docs
        .map((doc) => GroupModel.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();
  }
}