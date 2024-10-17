import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/business_logic/models/products_model.dart';
import 'package:test01/viewmodels/Product_viewmodel/Product_viewmodel.dart';
import 'package:test01/views/widgets/product_Card.dart';

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);

    return Container(child: 
      FutureBuilder<List<ProductModel>>(
        future: productViewModel.fetchProducts(), // Método para obtener productos
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar productos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay productos disponibles' ));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ProductCard(
                productName: product.name,
                productImageUrl: 'https://img.freepik.com/fotos-premium/planta-embotellado-linea-embotellado-agua-procesar-embotellar-agua-pura-manantial-botellas-azules-enfoque-selectivo_473712-850.jpg?w=360',
                providerImageUrl: 'https://img.freepik.com/fotos-premium/alegre-vendedor-callejero-sirviendo-clientes-sonrisa-fondo-suave-colores-claros_1081303-5208.jpg?w=360', // Puedes usar la URL de la imagen del proveedor si la tienes
                price: product.price,
                stock: product.stock,
                rating: 4.5, // Puedes modificar esto para obtener el rating real si lo tienes
              );
            },
          );
        },
      ),
    );
  }
}
