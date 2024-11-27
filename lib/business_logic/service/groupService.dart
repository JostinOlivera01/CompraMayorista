import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/group_model.dart';
import 'package:test01/business_logic/models/members_model.dart';

class GroupService {


  // Obtener todos los grupos desde Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


// Obtener los grupos en los que participa un integrante por su email
Future<List<GroupModel>> fetchGroupsByEmail(String email) async {
  try {
    // Obtener la colección de grupos
    QuerySnapshot snapshot = await _firestore.collection('Groups').get();

    print('Email del integrante: $email');
    List<GroupModel> groups = [];

    // Validar que hay documentos en la colección 'Groups'
    if (snapshot.docs.isEmpty) {
      print('No se encontraron grupos en la colección.');
      return groups;
    }

    // Iterar sobre cada documento de grupo
    for (var doc in snapshot.docs) {
      // Validar que los datos del grupo no sean nulos
      if (doc.data() == null || doc.data() is! Map<String, dynamic>) {
        print('El documento del grupo está vacío o no es válido: ${doc.id}');
        continue; // Saltar al siguiente documento
      }

      // Convertir los datos del grupo
      Map<String, dynamic> groupData = doc.data() as Map<String, dynamic>;
      GroupModel group;
      try {
        group = GroupModel.fromFirestore(groupData);
      } catch (e) {
        print('Error al convertir el grupo con ID ${doc.id}: $e');
        continue;
      }

      // Obtener la subcolección 'integrantes'
      QuerySnapshot integrantesSnapshot;
      try {
        integrantesSnapshot = await _firestore
            .collection('Groups')
            .doc(doc.id)
            .collection('integrantes')
            .get();
      } catch (e) {
        print('Error al obtener integrantes para el grupo ${doc.id}: $e');
        continue;
      }

      // Validar que hay integrantes en la subcolección
      if (integrantesSnapshot.docs.isEmpty) {
        print('El grupo ${doc.id} no tiene integrantes.');
        continue;
      }

      // Convertir documentos de integrantes a objetos IntegranteModel
      List<IntegranteModel> integrantes = integrantesSnapshot.docs.map((integranteDoc) {
        try {
          return IntegranteModel.fromJson(
            integranteDoc.id,
            integranteDoc.data() as Map<String, dynamic>,
          );
        } catch (e) {
          print('Error al convertir el integrante ${integranteDoc.id}: $e');
          return IntegranteModel(id: integranteDoc.id, email: email, id_orden_compra: "integranteDoc", stockComprado: 3, totalPagado: 3, user_profile: "user_profile"); // Ignorar el integrante inválido
        }
      }).where((integrante) => integrante != null).toList();

      // Asignar la lista de integrantes al grupo
      group.integrantes = integrantes;

      // Verificar si el email del integrante está en el grupo
      bool integranteEncontrado = integrantes.any((integrante) => integrante.email == email);

      // Si pertenece al grupo, añadirlo a la lista
      if (integranteEncontrado) {
        groups.add(group);
      }
    }

    // Validar si se encontraron grupos
    if (groups.isEmpty) {
      print('No se encontraron grupos para el email proporcionado: $email');
    }

    return groups;
  } catch (e) {
    print('Error inesperado al obtener los grupos por email: $e');
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

Future<GroupModel?> getGroupById(String groupId) async {
  try {
    // Obtener el documento del grupo
    DocumentSnapshot doc = await _firestore.collection('Groups').doc(groupId).get();

    if (doc.exists) {
      print(doc.exists);

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

      print("Integrantes cargados: ${integrantes.length}");

      // Agregar la lista de integrantes al modelo del grupo
      return GroupModel.fromFirestore(groupData, integrantes: integrantes); // Pasar los integrantes al modelo
    }
    return null;
  } catch (e) {
    print('Error al obtener grupo por ID: $e');
    return null;
  }
}


  
}