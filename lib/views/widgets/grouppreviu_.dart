import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test01/business_logic/models/ad_model.dart';
import 'package:test01/business_logic/models/cart_model.dart';
import 'package:test01/business_logic/models/group_model.dart';
import 'package:test01/viewmodels/Gruop_viewmodel/Group_viewmodel.dart';
import 'package:test01/viewmodels/Product_viewmodel/cart_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';

class GroupPurchaseBottomSheet extends StatefulWidget {
  final Ad ad;

  const GroupPurchaseBottomSheet({super.key, required this.ad});

  @override
  _GroupPurchaseBottomSheetState createState() =>
      _GroupPurchaseBottomSheetState();
}

class _GroupPurchaseBottomSheetState extends State<GroupPurchaseBottomSheet> {
  int _selectedQuantity = 1;
  GroupModel? groupDetails;

  @override
  void initState() {
    super.initState();
    _loadGroupDetails();
  }

  Future<void> _loadGroupDetails() async {
    final groupViewModel = Provider.of<GroupViewModel>(context, listen: false);
    final group = await groupViewModel.fetchGroupById(widget.ad.refIdGroup);
    setState(() {
      groupDetails = group;
      _selectedQuantity = group?.minGroupPurchase ?? 1;
    });
  }

  double get totalPrice {
    return _selectedQuantity * (groupDetails?.productPrice ?? 0.0);
  }

  void _incrementQuantity() {
    setState(() {
      if (_selectedQuantity < (groupDetails?.stockLimit ?? widget.ad.minimumStock)) {
        _selectedQuantity++;
      }
    });
  }

  void _decrementQuantity() {
    setState(() {
      if (_selectedQuantity > (groupDetails?.minGroupPurchase ?? 1)) {
        _selectedQuantity--;
      }
    });
  }

  void _addToCart() {
    final cartViewModel = Provider.of<CartViewModel>(context, listen: false);
    final emailviewmodel  = Provider.of<UsuarioViewModel>(context, listen: false);

    print(widget.ad.emailVendedor);


    cartViewModel.addCart(CartModel(
      cartId: DateTime.now().toString(),
      adId: widget.ad.id ?? '',
      requestedStock: _selectedQuantity,
      amountToPay: totalPrice,
      groupId:  widget.ad.refIdGroup,
      Name:  widget.ad.productName,
      buyerEmail: emailviewmodel.email ?? '', 
      providerId: widget.ad.emailVendedor,
      ImgUrl: widget.ad.imgUrl ?? 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png?20210521171500'
    ));

      Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: groupDetails == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      groupDetails?.imgUrl ?? ' https://firebasestorage.googleapis.com/v0/b/compras-mayoristas.firebasestorage.app/o/images%2F1731979281971?alt=media&token=6559ac9a-9672-47ce-9330-6f1f95d25f65',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Descripción del producto
                  Text(
                    groupDetails!.productName,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${groupDetails!.productPrice.toStringAsFixed(0)}',
                    style: TextStyle(fontSize: 20, color: const Color.fromARGB(255, 12, 185, 9)),
                  ),
                  const SizedBox(height: 16),

                  // Información de la compra grupal
                  _buildGroupDetailsSection(),
                  const SizedBox(height: 16),

                  // Selector de cantidad
                  _buildQuantitySelector(),
                  const SizedBox(height: 16),

                  // Total a pagar
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Total a Pagar: \$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botón de compra
                  
                  ElevatedButton(
                    onPressed: _selectedQuantity <= groupDetails!.stockLimit
                        ? _addToCart
                        : null,
                    child: const Text('Añadir al carrito'),
                    
                  ),
                  
                ],
              ),
            ),
    );
  }

  Widget _buildGroupDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detalles del Grupo',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
        const SizedBox(height: 8),
        Text(
          'Proveedor: ${groupDetails!.productId}', // Cambia `productId` por el nombre real del proveedor si está disponible
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          'Máximo de Participantes: ${groupDetails!.maxGroupSize}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          'Cuota Mínima de Ingreso: ${groupDetails!.minGroupPurchase}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          'Limite de Stock: ${groupDetails!.stockLimit.toString()}',
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          'Fecha límite: ${DateFormat('dd/MM/yyyy').format(groupDetails!.deadline)}',
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Cantidad a comprar:',
          style: TextStyle(fontSize: 16),
        ),
        Row(
          children: [
            IconButton(
              onPressed: _decrementQuantity,
              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            ),
            Text(
              '$_selectedQuantity',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: _incrementQuantity,
              icon: const Icon(Icons.add_circle_outline, color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }
}
