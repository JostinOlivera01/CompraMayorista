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
            const SizedBox(height: 16),          ],
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
            price: ad.precioProduct ?? 0,
            stock: ad.publishedStock,
            deadline: ad.publicationDate,
            status: ad.status,
            type: ad.publicationType, // Nuevo campo para el tipo de anuncio
            members: ['dsds','dssd'],
            imageUrl: ad.imgUrl
          );
        }),
      ],
    );
  }

Widget _productCard({
  required String productName,
  required int price,
  required int stock,
  required DateTime deadline,
  required String status,
  required String type, // Diferenciador para Individual y Grupal
  required List<String> members,
  String? imageUrl, // Agregar parámetro opcional para la URL de la imagen
}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 2,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[300],
                backgroundImage: imageUrl != null && imageUrl.isNotEmpty
                    ? NetworkImage(imageUrl) // Mostrar imagen si hay URL válida
                    : null, // Dejar vacío si no hay URL
                child: imageUrl == null || imageUrl.isEmpty
                    ? Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                      ) // Ícono de respaldo si no hay URL
                    : null,
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
                    Text(
                        'Fecha: ${DateFormat('dd/MM/yyyy').format(deadline)}'),
                    Text('Estado: $status'),
                  ],
                ),
              ),
              // Agregar texto estilizado en lugar del ícono
              _adTypeLabel(type),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Integrantes:'),
          Row(
            children: members.map((url) {
              return Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: CircleAvatar(
                  radius: 12,
                  backgroundImage: NetworkImage(url),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

Widget _adTypeLabel(String type) {
  final Color backgroundColor =
      type == 'Individual' ? Colors.green : Colors.lightBlue;
  final String labelText = type == 'Individual' ? 'Individual' : 'Grupal';

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      labelText,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
}
