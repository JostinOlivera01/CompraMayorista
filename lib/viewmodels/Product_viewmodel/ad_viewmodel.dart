import 'package:flutter/material.dart';
import 'package:test01/business_logic/actions/User_actions/ad_actions.dart';
import 'package:test01/business_logic/models/ad_model.dart';
import 'package:test01/business_logic/models/group_model.dart';

class AdvertisementViewModel extends ChangeNotifier {
  final AdvertisementActions _advertisementActions;
  List<Ad> advertisements = [];

  AdvertisementViewModel(this._advertisementActions);

  // Método para obtener todos los anuncios y actualizar la lista
  Future<List<Ad>> fetchAdvertisements() async {
    try {
      advertisements = await _advertisementActions.getAllAdvertisements();
      notifyListeners(); // Notificar cambios en la vista
      return advertisements;
    } catch (e) {
      print('Error al obtener anuncios: $e');
      return [];
    }
  }

  // Método para crear un anuncio individual
  Future<bool> createIndividualAd(Ad advertisement) async {
    bool success = await _advertisementActions.createAdvertisementIndividual(advertisement);
    if (success) {
      await fetchAdvertisements(); // Refresca la lista después de crear
    }
    return success;
  }

  // Método para crear un anuncio grupal
  Future<bool> createGroupAd(Ad advertisement, GroupModel group) async {
    bool success = await _advertisementActions.createAdvertisementGroup(advertisement, group);
    if (success) {
      await fetchAdvertisements(); // Refresca la lista después de crear
    }
    return success;
  }
}
