import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/Gruop_viewmodel/Group_viewmodel.dart';
import 'package:test01/viewmodels/Pagos_viewmdel/factura_viewmodel.dart';
import 'package:test01/views/screen/Buyer/widget/Detalle%20Grupo/groupDetail.dart';
import 'package:test01/views/screen/Buyer/widget/Detalle%20Grupo/groupResumen_screen.dart';
import 'package:test01/views/screen/Buyer/widget/providerDetail.dart';

class GroupPurchaseContent extends StatefulWidget {
  final String idOrdenCompra;

  const GroupPurchaseContent({super.key, required this.idOrdenCompra});

  @override
  _GroupPurchaseContentState createState() => _GroupPurchaseContentState();
}




enum DrawerType { participants, withdrawal }

class _GroupPurchaseContentState extends State<GroupPurchaseContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late FacturaViewModel facturaViewModel;
  late GroupViewModel groupViewModel;
  DrawerType _currentDrawerType = DrawerType.participants; // Estado que controla qué Drawer mostrar

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    facturaViewModel = Provider.of<FacturaViewModel>(context, listen: false);
    groupViewModel = Provider.of<GroupViewModel>(context, listen: false);
    fetchData();
  }

  Future<void> fetchData() async {
    await facturaViewModel.cargarFacturaPorIdOrdenCompra(widget.idOrdenCompra);
    final idGroup = facturaViewModel.facturaEncontrada?.groupId ?? '';
    if (idGroup.isNotEmpty) {
      await groupViewModel.fetchGroupById(idGroup);
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
      endDrawer: _buildDrawer(), // Drawer dinámico
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Consumer2<FacturaViewModel, GroupViewModel>(
                  builder: (context, facturaVM, groupVM, child) {
                    final integrantes = groupVM.grupoEncontrado?.integrantes ?? [];
                    final participantImages = integrantes.map((integrante) {
                      return 'https://img.freepik.com/vector-premium/circulo-usuario-circulo-gradiente-azul_78370-4727.jpg?w=740';
                    }).toList();

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Image.network(
                            groupVM.grupoEncontrado?.imgUrl ?? 'https://img.freepik.com/vector-premium/circulo-usuario-circulo-gradiente-azul_78370-4727.jpg?w=740',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            groupVM.grupoEncontrado?.productName ?? 'Producto Sin Nombre',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ProviderDetailWidget(
                            name: facturaVM.facturaEncontrada?.idOrdenCompra ?? 'Nombre Distribuidora',
                            socialReason: facturaVM.facturaEncontrada?.nombreProveedor ?? 'Distribuidora',
                            folio: facturaVM.facturaEncontrada?.idFactura ?? 0,
                            companyNumber: 624849,
                            profileImageUrl: 'https://img.freepik.com/vector-premium/circulo-usuario-circulo-gradiente-azul_78370-4727.jpg?w=740',
                          ),
                          GroupDetailWidget(
                            groupName: groupVM.grupoEncontrado?.productName ?? 'Sin Nombre',
                            remainingQuantity: groupVM.grupoEncontrado?.maxGroupSize ?? 0,
                            status: groupVM.grupoEncontrado?.description ?? 'DESCONOCIDO',
                            participantImages: participantImages,
                          ),
                          const SizedBox(height: 20),
                          _buildPhaseButton(
                            'Reclutamiento de compradores',
                            'VER PARTICIPANTES',
                            onTap: () {
                              setState(() {
                                _currentDrawerType = DrawerType.participants; // Cambiar a "participantes"
                              });
                              Scaffold.of(context).openEndDrawer(); // Abre el drawer
                            },
                          ),
                          _buildPhaseButton(
                            'Fase de Retiro o despacho',
                            'dsadsa',
                            onTap: () {
                              setState(() {
                                _currentDrawerType = DrawerType.withdrawal; // Cambiar a "retirar"
                              });
                              Scaffold.of(context).openEndDrawer(); // Abre el drawer
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const ResumenTabContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    switch (_currentDrawerType) {
      case DrawerType.participants:
        return _buildParticipantsDrawer(); // Muestra el drawer de participantes
      case DrawerType.withdrawal:
        return _buildWithdrawalDrawer(); // Muestra el drawer de retiro
    }
  }

  Widget _buildParticipantsDrawer() {
    return Consumer<GroupViewModel>(
      builder: (context, groupVM, child) {
        final integrantes = groupVM.grupoEncontrado?.integrantes ?? [];
        return Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DrawerHeader(
                child: Text(
                  'Participantes',
                  style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: integrantes.length,
                  itemBuilder: (context, index) {
                    final integrante = integrantes[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://img.freepik.com/vector-premium/circulo-usuario-circulo-gradiente-azul_78370-4727.jpg?w=740',
                        ),
                      ),
                      title: Text(integrante.email),
                      subtitle: Text('Stock Comprado: ${integrante.stockComprado}'),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWithdrawalDrawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Detalle de Retiro',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Text(
              'Dirección de Retiro: Calle Falsa 123, Ciudad, País',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Text(
              'Detalles del Producto:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Nombre: Producto de Ejemplo'),
                Text('Cantidad: 3 unidades'),
                Text('Precio: \$45.00'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: const Text(
                'CÓDIGO: ABC123XYZ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhaseButton(String title, String subtitle, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
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
