import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/group_model.dart';
import 'package:test01/business_logic/models/members_model.dart';

class GroupService {


  // Obtener todos los grupos desde Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


// Obtener los grupos en los que participa un integrante por su email
Future<List<GroupModel>> fetchGroupsByEmail(String email) async {
  try {
    QuerySnapshot snapshot = await _firestore.collection('Groups').get();

    // Lista de grupos en los que participa el integrante
    List<GroupModel> groups = [];

    // Iterar sobre cada documento de grupo
    for (var doc in snapshot.docs) {
      // Convertir los datos del grupo
      Map<String, dynamic> groupData = doc.data() as Map<String, dynamic>;
      GroupModel group = GroupModel.fromFirestore(groupData);

      // Obtener la subcolección de integrantes
      QuerySnapshot integrantesSnapshot = await _firestore
          .collection('Groups')
          .doc(doc.id)
          .collection('integrantes')
          .get();

      // Convertir los documentos de integrantes a objetos IntegranteModel
      List<IntegranteModel> integrantes = integrantesSnapshot.docs.map((integranteDoc) {
        return IntegranteModel.fromJson(
          integranteDoc.id,
          integranteDoc.data() as Map<String, dynamic>,
        );
      }).toList();

      // Asignar la lista de integrantes al grupo
      group.integrantes = integrantes;

      // Verificar si el integrante está en este grupo
      bool integranteEncontrado = integrantes.any((integrante) => integrante.email == email);

      // Si el integrante pertenece al grupo, añadirlo a la lista
      if (integranteEncontrado) {
        groups.add(group);
      }
    }

    return groups;
  } catch (e) {
    print('Error al obtener los grupos por email del integrante: $e');
    return [];
  }
}






  // Obtener todos los grupos junto con sus integrantes
  Future<List<GroupModel>> fetchGroups() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('Groups').get();

      // Lista de grupos que incluya a los integrantes
      List<GroupModel> groups = [];

      // Iterar sobre cada documento de grupo
      for (var doc in snapshot.docs) {
        // Convertir los datos del grupo
        Map<String, dynamic> groupData = doc.data() as Map<String, dynamic>;
        GroupModel group = GroupModel.fromFirestore(groupData);

        // Obtener la subcolección de integrantes
        QuerySnapshot integrantesSnapshot = await _firestore
            .collection('Groups')
            .doc(doc.id)
            .collection('integrantes')
            .get();

        // Convertir los documentos de integrantes a objetos IntegranteModel
        List<IntegranteModel> integrantes = integrantesSnapshot.docs.map((integranteDoc) {
          return IntegranteModel.fromJson(
            integranteDoc.id,
            integranteDoc.data() as Map<String, dynamic>,
          );
        }).toList();

        // Asignar la lista de integrantes al grupo
        group.integrantes = integrantes;

        // Añadir el grupo completo a la lista de grupos
        groups.add(group);
      }

      return groups;
    } catch (e) {
      print('Error al obtener los grupos con sus integrantes: $e');
      return [];
    }
  }


// Obtener un grupo específico por ID junto con sus integrantes
Future<GroupModel?> getGroupById(String groupId) async {
  try {
    // Obtener el documento del grupo
    DocumentSnapshot doc = await _firestore.collection('Groups').doc(groupId).get();

    if (doc.exists) {
      // Convertir datos del grupo
      Map<String, dynamic> groupData = doc.data() as Map<String, dynamic>;

      // Obtener la subcolección de integrantes
      QuerySnapshot integrantesSnapshot = await _firestore
          .collection('Groups')
          .doc(groupId)
          .collection('integrantes')
          .get();

      // Convertir los documentos de integrantes a objetos IntegranteModel
      List<IntegranteModel> integrantes = integrantesSnapshot.docs.map((integranteDoc) {
        return IntegranteModel.fromJson(
          integranteDoc.id,
          integranteDoc.data() as Map<String, dynamic>,
        );
      }).toList();

      print(integrantes.isEmpty);
      print("----");

      // Agregar la lista de integrantes al modelo del grupo
      return GroupModel.fromFirestore(groupData)..integrantes = integrantes;
    }
    return null;
  } catch (e) {
    print('Error al obtener grupo por ID: $e');
    return null;
  }
}



  
}