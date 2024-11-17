import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/Gruop_viewmodel/Group_viewmodel.dart';
import 'package:test01/viewmodels/Product_viewmodel/factura_viewmodel.dart';
import 'package:test01/views/screen/Buyer/widget/Detalle%20Grupo/groupDetail.dart';
import 'package:test01/views/screen/Buyer/widget/Detalle%20Grupo/groupResumen_screen.dart';
import 'package:test01/views/screen/Buyer/widget/providerDetail.dart';

class GroupPurchaseContent extends StatefulWidget {
  final String idOrdenCompra; // Recibe el id_orden_compra
  const GroupPurchaseContent({super.key, required this.idOrdenCompra});

  @override
  _GroupPurchaseContentState createState() => _GroupPurchaseContentState();
}

class _GroupPurchaseContentState extends State<GroupPurchaseContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late FacturaViewModel facturaViewModel;
  late GroupViewModel groupViewModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Inicializar los viewmodels
    facturaViewModel = Provider.of<FacturaViewModel>(context, listen: false);
    groupViewModel = Provider.of<GroupViewModel>(context, listen: false);

    // Cargar los datos de la factura y grupo al inicializar
    fetchData();
  }

  Future<void> fetchData() async {
    await facturaViewModel.cargarFacturaPorIdOrdenCompra(widget.idOrdenCompra); // Cargar la factura por id_orden_compra
    final idGroup = facturaViewModel.facturaEncontrada?.groupId ?? ''; // Obtener el id del grupo desde la factura
    if (idGroup.isNotEmpty) {
      await groupViewModel.fetchGroupById(idGroup); // Cargar el grupo usando el id del grupo
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Purchase'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Fases de Grupo'),
            Tab(text: 'Resumen'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Contenido de la pestaña "Fases de Grupo"
                Consumer2<FacturaViewModel, GroupViewModel>(
                  builder: (context, facturaVM, groupVM, child) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          // Imagen del producto
                          Image.network(
                            'https://img.freepik.com/foto-gratis/vaso-papel_1339-349.jpg?t=st=1731243254~exp=1731246854~hmac=4af9fced4389107f29195149ecb486f2f75125d0e032437485e5f8ea7efa00f0&w=996',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20),
                          // Información del proveedor
                          ProviderDetailWidget(
                            name: facturaVM.facturaEncontrada?.idOrdenCompra ?? 'Nombre Distribuidora',
                            socialReason: facturaVM.facturaEncontrada?.nombreProveedor ?? 'Nombre Distribuidora',
                            folio: facturaVM.facturaEncontrada?.idFactura ?? 0,
                            companyNumber: 624849,
                            profileImageUrl: 'https://img.freepik.com/foto-gratis/vaso-papel_1339-349.jpg?t=st=1731243254~exp=1731246854~hmac=4af9fced4389107f29195149ecb486f2f75125d0e032437485e5f8ea7efa00f0&w=996',
                          ),
                          // Detalles del grupo
                          GroupDetailWidget(
                              groupName: groupVM.grupoEncontrado?.adId ?? '',
                              remainingQuantity: groupVM.grupoEncontrado?.maxGroupSize ?? 43,
                              status: groupVM.grupoEncontrado?.productName ?? '',
                              participantImages: groupVM.grupoEncontrado?.integrantes.map((integrante) {
                                return integrante.user_profile.isNotEmpty ? integrante.user_profile : 'https://img.freepik.com/vector-premium/circulo-usuario-circulo-gradiente-azul_78370-4727.jpg?w=740'; 
                              }).toList() ?? [],  // Si no hay integrantes, se retorna una lista vacía

                            ),
                          const SizedBox(height: 20),
                          _buildPhaseButton('Cuota de ingreso', 'VER BOLETA'),
                          _buildPhaseButton('Reclutamiento de compradores', 'VER PARTICIPANTES'),
                          _buildPhaseButton('Fase de Retiro o despacho', ''),
                        ],
                      ),
                    );
                  },
                ),
                // Contenido de la pestaña "Resumen"
                const ResumenTabContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseButton(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            if (subtitle.isNotEmpty)
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
