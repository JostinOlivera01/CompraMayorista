class Factura {
  String idOrdenCompra;
  String cantidadProducto;
  String descripcionProducto;
  String emailMercadoComprador;
  String emailProveedor;
  String fechaDePago;
  String formaDePago;
  String groupId;
  int idFactura;
  String idProducto;
  String ivaProducto;
  String nombreComprador;
  String nombreProducto;
  String nombreProveedor;
  int precioUnidad;
  String rutComprador;
  String rutProveedor;
  int totalProducto;

  Factura({
    required this.idOrdenCompra,
    required this.cantidadProducto,
    required this.descripcionProducto,
    required this.emailMercadoComprador,
    required this.emailProveedor,
    required this.fechaDePago,
    required this.formaDePago,
    required this.groupId,
    required this.idFactura,
    required this.idProducto,
    required this.ivaProducto,
    required this.nombreComprador,
    required this.nombreProducto,
    required this.nombreProveedor,
    required this.precioUnidad,
    required this.rutComprador,
    required this.rutProveedor,
    required this.totalProducto,
  });

  // Constructor para crear una instancia de Factura desde un mapa (JSON).
  factory Factura.fromJson(Map<String, dynamic> json) {
    return Factura(
      idOrdenCompra: json['id_orden_compra'] as String,
      cantidadProducto: json['cantidad_producto'] as String,
      descripcionProducto: json['descripcion_producto'] as String,
      emailMercadoComprador: json['email_mercado_comprador'] as String,
      emailProveedor: json['email_provedor'] as String,
      fechaDePago: json['fecha_de_pago'] as String,
      formaDePago: json['forma_de_pago'] as String,
      groupId: json['groupId'] as String,
      idFactura: json['id_factura'] as int,
      idProducto: json['id_producto'] as String,
      ivaProducto: json['iva_producto'] as String,
      nombreComprador: json['nombre_comprador'] as String,
      nombreProducto: json['nombre_producto'] as String,
      nombreProveedor: json['nombre_provedor'] as String,
      precioUnidad: json['precio_unidad'] as int,
      rutComprador: json['rut_comprador'] as String,
      rutProveedor: json['rut_provedor'] as String,
      totalProducto: json['total_producto'] as int,
    );
  }

  // Método para convertir una instancia de Factura a un mapa (JSON).
  Map<String, dynamic> toJson() {
    return {
      'id_orden_compra': idOrdenCompra,
      'cantidad_producto': cantidadProducto,
      'descripcion_producto': descripcionProducto,
      'email_mercado_comprador': emailMercadoComprador,
      'email_provedor': emailProveedor,
      'fecha_de_pago': fechaDePago,
      'forma_de_pago': formaDePago,
      'groupId': groupId,
      'id_factura': idFactura,
      'id_producto': idProducto,
      'iva_producto': ivaProducto,
      'nombre_comprador': nombreComprador,
      'nombre_producto': nombreProducto,
      'nombre_provedor': nombreProveedor,
      'precio_unidad': precioUnidad,
      'rut_comprador': rutComprador,
      'rut_provedor': rutProveedor,
      'total_producto': totalProducto,
    };
  }
}
