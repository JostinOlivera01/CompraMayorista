
import 'package:test01/business_logic/models/usuario_model.dart';
import 'package:test01/business_logic/service/usuarioStoreService.dart';


class UsuarioCaseStore {
  final UsuarioStoreService _StoreService;

  UsuarioCaseStore(this._StoreService);



  Future<void> register(UserStoreModel usuario) {
    UserStoreModel dataModel = usuario;
          print("JOSTINN3");

    return _StoreService.createUser(dataModel);
  }

  Future<UserStoreModel?> getUserByID(String userId){
    return _StoreService.getUserByID(userId);
  }


}