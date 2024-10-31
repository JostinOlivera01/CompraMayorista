import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/business_logic/models/products_model.dart';
import 'package:test01/viewmodels/Product_viewmodel/Product_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final emailViewModel = Provider.of<UsuarioViewModel>(context);
    final email = emailViewModel.email ?? ''; // Valor por defecto si es nulo


    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text(
            "¿Qué producto buscas?",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          // Barra de búsqueda
          TextField(
            decoration: InputDecoration(
              hintText: "Buscar por nombre del producto",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              filled: true,
              fillColor: Colors.purple[50],
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          SizedBox(height: 16),
          // Lista de productos
          Expanded(
            child: FutureBuilder<List<ProductModel>>(
              future: searchQuery.isNotEmpty
                  ? productViewModel.fetchProductsInventary(email, searchQuery)
                  : productViewModel.fetchProductsInventaryAll(email),
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
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        title: Text(product.name),
                        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
