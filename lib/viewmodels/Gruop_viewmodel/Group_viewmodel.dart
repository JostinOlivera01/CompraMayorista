import 'package:flutter/material.dart';
import 'package:test01/business_logic/actions/User_actions/group_actions.dart';
import 'package:test01/business_logic/models/group_model.dart';

class GroupViewModel extends ChangeNotifier {
  final GroupActions _groupActions;
  List<GroupModel> groups = [];

  GroupViewModel(this._groupActions);

  Future<List<GroupModel>> fetchGroups() async {
    try {
      print("JOSTIN3");
    return await _groupActions.getAllGroups();
    } catch (e) {
      print('Error al obtener grupos: $e');
      return [];
    }
  }
}