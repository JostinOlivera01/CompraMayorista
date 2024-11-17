import 'package:test01/business_logic/models/factura_model.dart';
import 'package:test01/business_logic/service/facturaService.dart';

class FacturaActions {
  final FacturaService _facturaService;
  FacturaActions(this._facturaService);

  // Acción para obtener facturas por email de proveedor
  Future<List<Factura>> obtenerFacturasPorEmailProveedor(String emailProveedor) {
    return _facturaService.obtenerFacturasPorEmailProveedor(emailProveedor);
  }

  // Acción para obtener facturas por email de comprador
  Future<List<Factura>> obtenerFacturasPorEmailComprador(String emailComprador) {
    return _facturaService.obtenerFacturasPorEmailComprador(emailComprador);
  }

  // Acción para obtener todas las facturas
  Future<List<Factura>> obtenerTodasLasFacturas() {
    return _facturaService.obtenerTodasLasFacturas();
  }

  // Acción para obtener una factura por ID de orden de compra
  Future<Factura?> obtenerFacturaPorIdOrdenCompra(String idOrdenCompra) {
    return _facturaService.obtenerFacturaPorIdOrdenCompra(idOrdenCompra);
  }
  
}
