import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/business_logic/models/products_model.dart';
import 'package:test01/viewmodels/Product_viewmodel/Orders_viewmodel.dart';
import 'package:test01/viewmodels/Product_viewmodel/Product_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Buyer/widget/product_Card.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);

    return Container(
      child: FutureBuilder<List<ProductModel>>(
        future: productViewModel.fetchProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar productos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay productos disponibles'));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return ProductCard(
                productName: product.name,
                productImageUrl: 'https://img.freepik.com/fotos-premium/planta-embotellado-linea-embotellado-agua-procesar-embotellar-agua-pura-manantial-botellas-azules-enfoque-selectivo_473712-850.jpg?w=360',
                providerImageUrl: 'https://img.freepik.com/fotos-premium/alegre-vendedor-callejero-sirviendo-clientes-sonrisa-fondo-suave-colores-claros_1081303-5208.jpg?w=360',
                price: product.price,
                stock: product.stock!,
                rating: 4.5,
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheetContent(product: product);
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class BottomSheetContent extends StatelessWidget {
  final ProductModel product;

  BottomSheetContent({required this.product});

  @override
  Widget build(BuildContext context) {
      final orderViewModel = Provider.of<OrdersViewmodel>(context);
      final userViewModel = Provider.of<UsuarioViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Para que la altura sea ajustada al contenido
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('Precio: \$${product.price.toStringAsFixed(2)}'),
          SizedBox(height: 10),
          Text('Stock: ${product.stock}'),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {

              orderViewModel.CreateOrderUser(
                'orderID23key232',
                userViewModel.email!,
                product.name,
                userViewModel.email!,
                product.name,
                product.description,
                product.price, 
                2,
                false,
                'Pendiente'
                );
            },
            child: Text('Añadir al carrito'),
          ),
        ],
      ),
    );
  }
}
