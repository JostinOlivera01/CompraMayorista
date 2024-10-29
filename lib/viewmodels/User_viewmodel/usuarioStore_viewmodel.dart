
import 'package:flutter/foundation.dart';
import 'package:test01/business_logic/actions/User_actions/usuarioStore_actions.dart';
import 'package:test01/business_logic/models/products_model.dart';
import 'package:test01/business_logic/models/usuario_model.dart';



class UsuarioViewModel extends ChangeNotifier {
  final UsuarioCaseStore _usercase;
  UsuarioViewModel(this._usercase);
  
  String? _role;
  
  String? email;
  
  String? get role => _role;

  // Cargar el rol del usuario después de iniciar sesión
  // Cargar el rol del usuario después de iniciar sesión
  Future<String?> loadUserRole(String userID) async {
    try {
      final user = await _usercase.getUserByID(userID);
      if (user != null) {
        if (_role != user.role) { // Solo notificar si el rol ha cambiado
          _role = user.role;    
          email = user.email;
          notifyListeners();
        }
        return _role; // Devolver el rol cargado
      }
    } catch (e) {
      // Manejo de errores, quizás logear el error o mostrar un mensaje
      print("Jostin: $e");
    }
    return null; // Devuelve null si no se pudo cargar el rol
  }

  Future<void> registerUser(String email, String name, String role, String userID) async {
    UserStoreModel newUser = UserStoreModel(
      userID: userID,
      email: email,
      name: name,
      role: role,
      registrationDate: DateTime.now(),
    );
    await _usercase.register(newUser);


  }

  Future<void> CreateProductUser(String productID, String providerID, String name, String description, double price, bool groupEnabled,  int stock,  DateTime createdAt) async {
    ProductModel newProductUser = ProductModel(
      productID: productID, 
      providerID: providerID, 
      name: name, 
      description: description, 
      price: price, 
      stock: stock, 
      groupEnabled: groupEnabled, 
      createdAt: createdAt);

    await _usercase.createProduct(newProductUser);
  }



}
