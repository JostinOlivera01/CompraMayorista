import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/Product_viewmodel/ad_viewmodel.dart';

class AnunciosPage extends StatelessWidget {
  const AnunciosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final adViewModel = Provider.of<AdvertisementViewModel>(context);

    // Llamar a fetchAds para cargar los anuncios cuando se abra la página
    adViewModel.fetchAdvertisements();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Anuncios',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _searchField(),
            const SizedBox(height: 16),
            _dropdownFilter(),
            const SizedBox(height: 16),
            _productsSection(adViewModel),
            const SizedBox(height: 16),
            _verMasButton(),
          ],
        ),
      ),
    );
  }

  Widget _searchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          hintText: 'Buscar en tus anuncios',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _dropdownFilter() {
    return Row(
      children: const [
        Text(
          'Todas las publicaciones',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Icon(Icons.arrow_drop_down),
      ],
    );
  }

  Widget _productsSection(AdvertisementViewModel adViewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tus productos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // Listado dinámico de anuncios
        ...adViewModel.advertisements.map((ad) {
          return _productCard(
            productName: ad.productName,
            price: ad.precioProduct ?? 0.0,
            stock: ad.publishedStock,
            deadline: ad.publicationDate,
            status: ad.status,
            members: ["sa","dsa"]
          );
        }),
      ],
    );
  }

  Widget _productCard({
    required String productName,
    required double price,
    required int stock,
    required DateTime deadline,
    required String status,
    required List<String> members,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('\$$price'),
                  Text('Stock: $stock'),
                  Text('Fecha: ${DateFormat('dd/MM/yyyy').format(deadline)}'),
                  Text('Estado: $status'),
                  const Text('Integrantes:'),
                  Row(
                    children: members.map((url) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage('https://img.freepik.com/foto-gratis/losas-pavimentacion-sobre-paletas-almacenamiento-mercancias-construccion-reparacion-entrega-venta-materiales-construccion_166373-3214.jpg?t=st=1730865945~exp=1730869545~hmac=9a835dbe6d5fbf20100bb20fd6049cc3771f99a0e370a6baf7e11ed357146bf1&w=996'),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const Icon(Icons.more_vert),
          ],
        ),
      ),
    );
  }

  Widget _verMasButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          // Acción para cargar más productos
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text('Ver más'),
      ),
    );
  }
}
