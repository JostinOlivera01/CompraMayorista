
class CartModel {
  final String cartId;             // ID único del carrito
  final String adId;               // ID del anuncio
  final String? groupId;           // ID del grupo (puede ser null para compras individuales)
  final int requestedStock;        // Stock solicitado por el comprador
  final String Name;               // Nombre del producto
  final String buyerEmail;         // Email del comprador
  final double amountToPay;        // Valor total a pagar por la compra
  final String? directPurchaseId;  // ID para compras directas (null en compras grupales)
  final String providerId;         // ID del proveedor

  CartModel({
    required this.cartId,
    required this.adId,
    this.groupId,
    required this.requestedStock,
    required this.Name,
    required this.buyerEmail,
    required this.amountToPay,
    this.directPurchaseId,
    required this.providerId,      // Nuevo campo obligatorio para el ID del proveedor
  });

  // Método para convertir el modelo a un mapa para guardar en Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'cartId': cartId,
      'adId': adId,
      'groupId': groupId,
      'requestedStock': requestedStock,
      'Name': Name,
      'buyerEmail': buyerEmail,
      'amountToPay': amountToPay,
      'directPurchaseId': directPurchaseId,
      'providerId': providerId,      // Asegurarse de incluirlo aquí para Firestore
    };
  }

  // Factory para crear una instancia de CartModel desde un documento de Firestore
  factory CartModel.fromFirestore(Map<String, dynamic> data) {
    return CartModel(
      cartId: data['cartId'] ?? '',
      adId: data['adId'] ?? '',
      groupId: data['groupId'],                       // Puede ser null si no es una compra grupal
      requestedStock: data['requestedStock'] ?? 0,
      Name: data['Name'] ?? '',
      buyerEmail: data['buyerEmail'] ?? '',
      amountToPay: (data['amountToPay'] != null ? (data['amountToPay'] as num).toDouble() : 0.0),
      directPurchaseId: data['directPurchaseId'],     // Puede ser null si no es una compra directa
      providerId: data['providerId'] ?? '',           // Inicializar el providerId desde Firestore
    );
  }
}
