import 'package:test01/business_logic/models/group_model.dart';
import 'package:test01/business_logic/service/groupService.dart';

class GroupActions {
  final GroupService _groupService;

  GroupActions(this._groupService);

  // Obtener todos los grupos desde Firestore
  Future<List<GroupModel>> getAllGroups() async {
    try {
      return await _groupService.getAllGroups();
    } catch (e) {
      print('Error en GroupActions: $e');
      throw Exception(e);
    }
  }
}