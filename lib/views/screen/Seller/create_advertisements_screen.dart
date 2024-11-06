import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test01/business_logic/models/ad_model.dart';
import 'package:test01/business_logic/models/products_model.dart';
import 'package:test01/business_logic/models/group_model.dart';
import 'package:test01/viewmodels/Product_viewmodel/ad_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';

class CreateAnnouncementModal extends StatefulWidget {
  final ProductModel product;

  CreateAnnouncementModal({required this.product});

  @override
  _CreateAnnouncementModalState createState() => _CreateAnnouncementModalState();
}

class _CreateAnnouncementModalState extends State<CreateAnnouncementModal> {
  bool isGroupPurchase = false;
  final TextEditingController maxGroupSizeController = TextEditingController();
  final TextEditingController stockLimitController = TextEditingController();
  final TextEditingController minGroupPurchaseController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();

  DateTime? selectedDeadline; // Define selectedDeadline as DateTime

  @override
  void initState() {
    super.initState();
    if (widget.product.groupThreshold != null) {
      maxGroupSizeController.text = widget.product.groupThreshold.toString();
    }
    if (widget.product.stock != null) {
      stockLimitController.text = widget.product.stock.toString();
    }
    if (widget.product.minGroupPurchaseQuantity != null) {
      minGroupPurchaseController.text = widget.product.minGroupPurchaseQuantity.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final advertisementViewModel = Provider.of<AdvertisementViewModel>(context);
    final usuarioViewModel = Provider.of<UsuarioViewModel>(context);

    return Container(
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de la Imagen y detalles del producto
            Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: widget.product.imageURL != null
                        ? Image.network(
                            'https://img.freepik.com/foto-gratis/losas-pavimentacion-sobre-paletas-almacenamiento-mercancias-construccion-reparacion-entrega-venta-materiales-construccion_166373-3214.jpg?t=st=1730865945~exp=1730869545~hmac=9a835dbe6d5fbf20100bb20fd6049cc3771f99a0e370a6baf7e11ed357146bf1&w=996',
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 150,
                            width: double.infinity,
                            color: Colors.grey[300],
                            child: Icon(Icons.image, size: 50, color: Colors.grey[700]),
                          ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    widget.product.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('Producto: ${widget.product.description}'),
                  if (widget.product.category != null)
                    Text('Categoría: ${widget.product.category}'),
                  Text('RefId: ${widget.product.productID}'),
                  Text('Estado: ${widget.product.groupEnabled ? "Activo" : "Inactivo"}'),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Stock: ${widget.product.stock ?? 0} unidades',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Precio: \$${widget.product.price.toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                  if (widget.product.groupEnabled && widget.product.groupPrice != null)
                    Text(
                      'Precio Grupal: \$${widget.product.groupPrice!.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  SizedBox(height: 16),
                  Divider(),
                ],
              ),
            ),

            // Título y selector de tipo de anuncio
            Text(
              'Crear Anuncio',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Tipo de Anuncio'),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isGroupPurchase = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isGroupPurchase ? Colors.grey : Colors.blue,
                    ),
                    child: Text('Compra Directa'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isGroupPurchase = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isGroupPurchase ? Colors.blue : Colors.grey,
                    ),
                    child: Text('Compra Grupal'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Campos adicionales para "Compra Grupal"
            if (isGroupPurchase) ...[
              TextFormField(
                controller: maxGroupSizeController,
                decoration: InputDecoration(labelText: 'Tamaño Máximo del Grupo'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: stockLimitController,
                decoration: InputDecoration(labelText: 'Límite de Stock'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: minGroupPurchaseController,
                decoration: InputDecoration(labelText: 'Compra Mínima del Grupo'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: deadlineController,
                decoration: InputDecoration(
                  labelText: 'Fecha Límite',
                  suffixIcon: Icon(Icons.calendar_today), // Añadir un icono de calendario
                ),
                readOnly: true, // Desactivar la edición manual
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDeadline ?? DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDeadline = picked;
                      deadlineController.text = DateFormat('yyyy-MM-dd').format(picked); // Formato de la fecha
                    });
                  }
                },
              ),
            ],
            SizedBox(height: 16),

            // Botón "Crear Anuncio"
            ElevatedButton(
              onPressed: () async {
                // Preparar datos de anuncio
                final ad = Ad(
                  productName: widget.product.name ?? 'Nombre no disponible', // Asignación por defecto si es nulo
                  description: widget.product.description ?? 'Sin descripción', // Asignación por defecto
                  category: widget.product.category ?? 'Sin categoría',
                  publicationDate: DateTime.now(),
                  publishedStock: int.tryParse(stockLimitController.text) ?? widget.product.stock ?? 0, // Verificación de nulos
                  minimumPurchase: widget.product.minGroupPurchaseQuantity ?? 1, // Valor predeterminado si es nulo
                  status: 'Activo',
                  publicationType: 'Individual',
                  minimumStock: 3,
                  emailVendedor: usuarioViewModel.email ?? 'email no disponible',
                  precioProduct: widget.product.price
                );
                if (isGroupPurchase) {
                  // Crear anuncio grupal
                  final group = GroupModel(
                    groupId: 'someGeneratedGroupId', // Asegúrate de generar o proporcionar un ID único
                    productId: widget.product.productID ?? 'productIdNoDisponible',
                    productPrice: widget.product.groupPrice ?? widget.product.price ?? 0.0,
                    productName: widget.product.name ?? 'Nombre no disponible',
                    description: widget.product.description ?? 'Sin descripción',
                    maxGroupSize: int.tryParse(maxGroupSizeController.text) ?? 0,
                    stockLimit: int.tryParse(stockLimitController.text) ?? widget.product.stock ?? 0,
                    minGroupPurchase: int.tryParse(minGroupPurchaseController.text) ?? 1,
                    deadline: selectedDeadline ?? DateTime.now().add(Duration(days: 7)), // Fecha límite seleccionada o por defecto
                  );
                  await advertisementViewModel.createGroupAd(ad, group);
                } else {
                  // Crear anuncio individual
                  await advertisementViewModel.createIndividualAd(ad);
                }

                Navigator.of(context).pop(); // Cerrar el BottomSheet después de crear el anuncio
              },
              child: Text('Crear Anuncio'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    maxGroupSizeController.dispose();
    stockLimitController.dispose();
    minGroupPurchaseController.dispose();
    deadlineController.dispose();
    super.dispose();
  }
}
