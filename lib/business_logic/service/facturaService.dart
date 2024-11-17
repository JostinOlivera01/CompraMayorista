import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test01/business_logic/models/factura_model.dart';

class FacturaService {
  // Referencia a la colección de facturas en Firestore
  final CollectionReference facturasRef =
      FirebaseFirestore.instance.collection('Factura');

  // Método para obtener facturas por email del proveedor
  Future<List<Factura>> obtenerFacturasPorEmailProveedor(String emailProveedor) async {
    try {
      final querySnapshot = await facturasRef
          .where('email_provedor', isEqualTo: emailProveedor)
          .get();

      return querySnapshot.docs
          .map((doc) => Factura.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error al obtener facturas por email de proveedor: $e');
      return [];
    }
  }

  // Método para obtener facturas por email del comprador
  Future<List<Factura>> obtenerFacturasPorEmailComprador(String emailComprador) async {
    try {
      final querySnapshot = await facturasRef
          .where('email_mercado_comprador', isEqualTo: emailComprador)
          .get();

      return querySnapshot.docs
          .map((doc) => Factura.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error al obtener facturas por email de comprador: $e');
      return [];
    }
  }

  // Método para obtener todas las facturas
  Future<List<Factura>> obtenerTodasLasFacturas() async {
    try {
      final querySnapshot = await facturasRef.get();

      return querySnapshot.docs
          .map((doc) => Factura.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error al obtener todas las facturas: $e');
      return [];
    }
  }

  // Método para obtener factura por ID de orden de compra
  Future<Factura?> obtenerFacturaPorIdOrdenCompra(String idOrdenCompra) async {
    try {
      final querySnapshot = await facturasRef
          .where('id_orden_compra', isEqualTo: idOrdenCompra)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return Factura.fromJson(querySnapshot.docs.first.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error al obtener factura por ID de orden de compra: $e');
      return null;
    }
  }
}
