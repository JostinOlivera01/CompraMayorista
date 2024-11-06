
import 'package:test01/business_logic/models/ad_model.dart';
import 'package:test01/business_logic/models/group_model.dart';
import 'package:test01/business_logic/service/advertisementsService.dart';

class AdvertisementActions {
  final AdvertisementService _advertisementService;

  AdvertisementActions(this._advertisementService);

  // Obtener todos los anuncios desde Firestore
  Future<List<Ad>> getAllAdvertisements() async {
    try {
      return await _advertisementService.getAllAdvertisements();
    } catch (e) {
      print('Error en AdvertisementActions: $e');
      throw Exception(e);
    }
  }

  // Crear un anuncio individual
  Future<bool> createAdvertisementIndividual(Ad advertisement) async {
    try {
      return await _advertisementService.createAdvertisementIndividual(advertisement);
    } catch (e) {
      print('Error al crear anuncio individual: $e');
      return false;
    }
  }

  // Crear un anuncio grupal y enlazarlo a un grupo en Firestore
  Future<bool> createAdvertisementGroup(Ad advertisement, GroupModel group) async {
    try {
      return await _advertisementService.createAdvertisementGroup(advertisement, group);
    } catch (e) {
      print('Error al crear anuncio grupal: $e');
      return false;
    }
  }
}
