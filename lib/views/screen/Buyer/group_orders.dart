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
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar grupos'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay grupos disponibles'));
        }

        final groups = snapshot.data!;

        return ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            final group = groups[index];

            // Buscar integrante por email
            final integrante = group.integrantes.firstWhere(
              (i) => i.email == emailViewModel.email,
              orElse: () => IntegranteModel(
                  email: '',
                  id_orden_compra: '',
                  stockComprado: 0,
                  totalPagado: 0,
                  id: '', 
                  user_profile: '',
                ), // Devuelve null si no se encuentra el integrante
            );
            return GestureDetector(
              onTap: () {
                if (integrante != null) {
                  // Navegar solo si se encuentra un integrante con el email especificado
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupPurchaseContent(
                        idOrdenCompra: integrante.id_orden_compra,
                      ),
                    ),
                  );
                } else {
                  // Mostrar mensaje si no hay integrante con el email deseado
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('No se encontró un integrante con el email especificado.'),
                    ),
                  );
                }
              },
              child: GroupCard(
                group: group,
                status: 'Activo',
                members: group.integrantes.map((integrante) {
                  return integrante.user_profile.isNotEmpty 
                      ? integrante.user_profile 
                      : 'https://img.freepik.com/vector-premium/circulo-usuario-circulo-gradiente-azul_78370-4727.jpg?w=740'; 
                }).toList() ?? [],
              ),
            );
          },
        );
      },
    );
  }
}
