import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/business_logic/models/group_model.dart';
import 'package:test01/business_logic/models/members_model.dart';
import 'package:test01/viewmodels/Gruop_viewmodel/Group_viewmodel.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';
import 'package:test01/views/screen/Buyer/widget/Detalle%20Grupo/group_screen.dart';
import 'package:test01/views/widgets/gruposcard_.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groupViewModel = Provider.of<GroupViewModel>(context);
    final emailViewModel = Provider.of<UsuarioViewModel>(context);

    return FutureBuilder<List<GroupModel>>(
      future: groupViewModel.fetchGroupsByEmail(emailViewModel.email ?? ''),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('Cargando datos de los grupos...');
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print('Error al cargar los grupos: ${snapshot.error}');
          return const Center(child: Text('Error al cargar grupos'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          print('No hay grupos disponibles.');
          return const Center(child: Text('No hay grupos disponibles'));
        }

        final groups = snapshot.data!;
        print('Se encontraron ${groups.length} grupos.');

        return ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            final group = groups[index];
            print('Cargando grupo: ${group.groupId}');
            print('Integrantes en el grupo: ${group.integrantes.length}');

            // Buscar integrante por email
            final integrante = group.integrantes.firstWhere(
              (i) => i.email == emailViewModel.email,
              orElse: () {
                print('Integrante con email ${emailViewModel.email} no encontrado en el grupo ${group.groupId}');
                return IntegranteModel(
                  email: '',
                  id_orden_compra: '',
                  stockComprado: 0,
                  totalPagado: 0,
                  id: '',
                  user_profile: '',
                );
              },
            );

            print('Datos del integrante encontrado:');
            print('Email: ${integrante.email}');
            print('ID Orden Compra: ${integrante.id_orden_compra}');
            print('Stock Comprado: ${integrante.stockComprado}');
            print('Total Pagado: ${integrante.totalPagado}');

            return GestureDetector(
              onTap: () {
                if (integrante.email.isNotEmpty && integrante.id_orden_compra.isNotEmpty) {
                  print('Navegando al detalle del grupo con ID Orden Compra: ${integrante.id_orden_compra}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupPurchaseContent(
                        idOrdenCompra: integrante.id_orden_compra,
                      ),
                    ),
                  );
                } else {
                  print('No se puede navegar. El integrante no tiene datos válidos.');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No se encontró información válida del integrante')),
                  );
                }
              },
              child: GroupCard(
                group: group,
                status: 'Activo',
                members: group.integrantes.map((integrante) {
                  print('Cargando imagen de perfil para integrante con email: ${integrante.email}');
                  return integrante.user_profile.isNotEmpty
                      ? 'https://img.freepik.com/vector-premium/circulo-usuario-circulo-gradiente-azul_78370-4727.jpg?w=740'
                      : 'https://img.freepik.com/vector-premium/circulo-usuario-circulo-gradiente-azul_78370-4727.jpg?w=740';
                }).toList(),
              ),
            );
          },
        );
      },
    );
  }
}
