import 'package:flutter/material.dart';
import 'package:test01/business_logic/actions/User_actions/group_actions.dart';
import 'package:test01/business_logic/models/group_model.dart';

class GroupViewModel extends ChangeNotifier {
  final GroupActions _groupActions;
  GroupViewModel(this._groupActions);

  List<GroupModel> groups = [];
  GroupModel? grupoEncontrado;


  // Obtener todos los grupos
  Future<List<GroupModel>> fetchGroups() async {
    try {
      return await _groupActions.getAllGroups();
    } catch (e) {
      print('Error al obtener grupos: $e');
      return [];
    }
  }

  // Obtener un grupo específico por ID
  Future<GroupModel?> fetchGroupById(String? groupId) async {
    try {
      print("VALENTINA");
      grupoEncontrado = await _groupActions.getgroupId(groupId!);
      print(grupoEncontrado);
      notifyListeners();
      return grupoEncontrado;
    } catch (e) {
      print('Error al obtener el grupo con ID $groupId: $e');
      return null;
    }
  }

  // Método para buscar grupos por email
  Future<List<GroupModel>> fetchGroupsByEmail(String email) async {
    try {
      return await _groupActions.fetchGroupsByEmail(email);

    } catch (e) {
      print('Error al obtener grupos: $e');
      return [];
    }
  }

  
}
