import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/ad_model.dart';
import 'package:test01/business_logic/models/group_model.dart';

class AdvertisementService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch all advertisements from Firestore
  Future<List<Ad>> getAllAdvertisements() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('Anuncios').get();
      print("JOSTIN");

      return snapshot.docs.map((doc) => Ad.fromDocument(doc)).toList();
    } catch (e) {
      print('Error fetching advertisements: $e');
      return [];
    }
  }

  // Create an individual advertisement and store its ID
  Future<bool> createAdvertisementIndividual(Ad advertisement) async {
    try {
      DocumentReference docRef = await _firestore.collection('Anuncios').add({
        'productName': advertisement.productName,
        'description': advertisement.description,
        'category': advertisement.category,
        'publicationDate': Timestamp.fromDate(advertisement.publicationDate),
        'publishedStock': advertisement.publishedStock,
        'publicationType': 'Individual',
        'minimumPurchase': advertisement.minimumPurchase,
        'minimumStock': advertisement.minimumStock,
        'status': advertisement.status,
        'emailVendedor': advertisement.emailVendedor,
      });

      // Guardar el ID generado en el anuncio en Firestore
      await docRef.update({'adId': docRef.id});

      return true;
    } catch (e) {
      print('Error creating individual advertisement: $e');
      return false;
    }
  }

  // Create a group advertisement and link it to a group document
  Future<bool> createAdvertisementGroup(Ad advertisement, GroupModel group) async {
    try {
      // Crear el documento del grupo en Firestore
      DocumentReference groupRef = await _firestore.collection('Groups').add(
        group.toFirestore()
        
        
        );

      // Crear el anuncio con referencia al grupo y guardar el ID del anuncio
      DocumentReference adRef = await _firestore.collection('Anuncios').add({
        'productName': advertisement.productName,
        'description': advertisement.description,
        'category': advertisement.category,
        'publicationDate': Timestamp.fromDate(advertisement.publicationDate),
        'publishedStock': advertisement.publishedStock,
        'publicationType': 'Group',
        'minimumPurchase': advertisement.minimumPurchase,
        'minimumStock': advertisement.minimumStock,
        'status': advertisement.status,
        'emailVendedor': advertisement.emailVendedor,
        'refIdGroup': groupRef.id,
      });

      // Actualizar el documento de anuncio con su ID en Firestore
      await adRef.update({'adId': adRef.id});
      await groupRef.update({'groupId':groupRef.id});
      await groupRef.update({'adId':adRef.id});

      return true;
    } catch (e) {
      print('Error creating group advertisement: $e');
      return false;
    }
  }
}
