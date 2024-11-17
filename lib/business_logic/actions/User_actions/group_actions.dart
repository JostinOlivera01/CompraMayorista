import 'package:test01/business_logic/models/group_model.dart';
import 'package:test01/business_logic/service/groupService.dart';

class GroupActions {
  final GroupService _groupService;

  GroupActions(this._groupService);

  // Obtener todos los grupos desde Firestore
  Future<List<GroupModel>> getAllGroups() async {
    try {
      return await _groupService.fetchGroups();
    } catch (e) {
      print('Error en GroupActions: $e');
      throw Exception(e);
    }
  }


  // Obtener todos los grupos desde Firestore
  Future<GroupModel?> getgroupId(String groupId) async {
    try {
      return await _groupService.getGroupById(groupId);
    } catch (e) {
      print('Error en GroupActions: $e');
      throw Exception(e);
    }
  }

    // Método para buscar grupos por email
  Future<List<GroupModel>> fetchGroupsByEmail(String email) async {
    try{
      return await _groupService.fetchGroupsByEmail(email);
    }catch (e){
      print('Error en GroupActions: $e');
      throw Exception(e);
    }
  }


}