import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/business_logic/models/ad_model.dart';
import 'package:test01/viewmodels/Product_viewmodel/ad_viewmodel.dart';
import 'package:test01/views/widgets/Adcarda_.dart';

class AdvertisementListScreen extends StatefulWidget {
  const AdvertisementListScreen({super.key});

  @override
  _AdvertisementListScreenState createState() => _AdvertisementListScreenState();
}

class _AdvertisementListScreenState extends State<AdvertisementListScreen> {
  late Future<List<Ad>> _fetchAdsFuture;

  @override
  void initState() {
    super.initState();
    // Obtiene la instancia de AdvertisementViewModel y llama fetchAdvertisements una vez
    final viewModel = Provider.of<AdvertisementViewModel>(context, listen: false);
    _fetchAdsFuture = viewModel.fetchAdvertisements();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ad>>(
      future: _fetchAdsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar anuncios'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay anuncios disponibles'));
        } else {
          final advertisements = snapshot.data!;
          return Container(
            color: Colors.grey[100],
            child: GridView.builder(
              itemCount: advertisements.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
              ),
              itemBuilder: (context, index) {
                return AdCard(ad: advertisements[index]);
              },
            ),
          );
        }
      },
    );
  }
}
