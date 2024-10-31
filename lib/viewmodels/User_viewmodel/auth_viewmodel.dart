// business_logic/view_model/auth_view_model.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:test01/business_logic/actions/User_actions/auth_actions.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';


class AuthViewModel extends ChangeNotifier {
  final AuthUseCase _authUseCase;

  User? _user;
  User? get user => _user;

  AuthViewModel(this._authUseCase) {
    _authUseCase.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signOut(context) async {
    await _authUseCase.signOut();
    notifyListeners();


  }

  Future<void> login(String email, String password) async {
    _user = await _authUseCase.login(email, password);
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    _user = await _authUseCase.register(email, password);
    notifyListeners();
  }
}
