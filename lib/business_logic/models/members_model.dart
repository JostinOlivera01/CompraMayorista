class IntegranteModel {
  final String id; // ID del documento del integrante
  final String email;
  final String id_orden_compra;
  final int stockComprado;
  final int totalPagado;
  final String user_profile; // Campo userProfile como String (URL)

  // Constructor
  IntegranteModel({
    required this.id,
    required this.email,
    required this.id_orden_compra,
    required this.stockComprado,
    required this.totalPagado,
    required this.user_profile, // Aseguramos que el campo esté presente en el constructor
  });

  // Método para mapear desde un documento Firestore
  factory IntegranteModel.fromJson(String id, Map<String, dynamic> json) {
    return IntegranteModel(
      id: id,
      email: json['email'] as String,
      id_orden_compra: json['id_orden_compra'] as String,
      stockComprado: json['stock_comprado'] as int,
      totalPagado: json['total_pagado'] as int,
      user_profile: json['user_profile'] as String, // Aquí mapeamos la URL
    );
  }

  // Método para mapear a Firestore
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'id_orden_compra': id_orden_compra,
      'stock_comprado': stockComprado,
      'total_pagado': totalPagado,
      'user_profile': user_profile, // Guardamos la URL en Firestore
    };
  }
}
