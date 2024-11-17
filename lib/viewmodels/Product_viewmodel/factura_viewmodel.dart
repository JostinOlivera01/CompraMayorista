import 'package:flutter/material.dart';
import 'package:test01/business_logic/actions/User_actions/factura_actions.dart';
import 'package:test01/business_logic/models/factura_model.dart';


class FacturaViewModel extends ChangeNotifier {
  final FacturaActions _facturaActions;
  FacturaViewModel(this._facturaActions);

  List<Factura> facturas = [];
  Factura? facturaEncontrada;
  bool isLoading = false;
  String? errorMessage;

  // Método para obtener facturas por email del proveedor
  Future<void> cargarFacturasPorEmailProveedor(String emailProveedor) async {
    _setLoading(true);
    try {
      facturas = await _facturaActions.obtenerFacturasPorEmailProveedor(emailProveedor);
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Error al obtener facturas del proveedor';
    }
    _setLoading(false);
  }

  // Método para obtener facturas por email del comprador
  Future<void> cargarFacturasPorEmailComprador(String emailComprador) async {
    _setLoading(true);
    try {
      facturas = await _facturaActions.obtenerFacturasPorEmailComprador(emailComprador);
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Error al obtener facturas del comprador';
    }
    _setLoading(false);
  }

  // Método para obtener todas las facturas
  Future<void> cargarTodasLasFacturas() async {
    _setLoading(true);
    try {
      facturas = await _facturaActions.obtenerTodasLasFacturas();
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Error al obtener todas las facturas';
    }
    _setLoading(false);
  }

  // Método para obtener una factura por ID de orden de compra
  Future<void> cargarFacturaPorIdOrdenCompra(String idOrdenCompra) async {
    try {
      print("FACTURA");
      print(idOrdenCompra);

      facturaEncontrada = await _facturaActions.obtenerFacturaPorIdOrdenCompra(idOrdenCompra);
      print(facturaEncontrada);

      errorMessage = facturaEncontrada != null ? null : 'Factura no encontrada';
    } catch (e) {
      errorMessage = 'Error al obtener la factura por ID de orden de compra';
    }
  }

  // Método para establecer el estado de carga
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
