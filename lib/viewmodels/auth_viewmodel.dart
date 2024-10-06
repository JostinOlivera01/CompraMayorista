// viewmodels/auth_viewmodel.dart
import '../models/user_model.dart';

class AuthViewModel {
  UserModel? _user;

  void register(String username, String password) {
    _user = UserModel(username: username, password: password);
    print("Usuario registrado: ${_user!.username}");
  }

  bool login(String username, String password) {
    if (_user != null && _user!.username == username && _user!.password == password) {
      return true;
    }
    return true;
  }
}


