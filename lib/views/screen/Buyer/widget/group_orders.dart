import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/business_logic/models/group_model.dart';
import 'package:test01/viewmodels/Gruop_viewmodel/Group_viewmodel.dart';
import 'package:test01/views/screen/Buyer/widget/group_Card.dart';


class GroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final groupViewModel = Provider.of<GroupViewModel>(context);

    return Container(
      child: FutureBuilder<List<GroupModel>>(
        future: groupViewModel.fetchGroups(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar grupos'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay grupos disponibles'));
          }

              final groups = snapshot.data!;

              return ListView.builder(
              itemCount: groups.length,
              itemBuilder: (context, index) {
              final group = groups[index];

              return GroupProductCard(
                groupId: group.groupId,
                productId: group.productId,
                productName: group.productName,
                productImageUrl: 'https://img.freepik.com/fotos-premium/planta-embotellado-linea-embotellado-agua-procesar-embotellar-agua-pura-manantial-botellas-azules-enfoque-selectivo_473712-850.jpg?w=360', // Reemplaza con la URL de la imagen real
                providerImageUrl: 'https://img.freepik.com/fotos-premium/planta-embotellado-linea-embotellado-agua-procesar-embotellar-agua-pura-manantial-botellas-azules-enfoque-selectivo_473712-850.jpg?w=360', // Reemplaza con la URL de la imagen real del proveedor
                productPrice: group.productPrice,
                deadline: group.deadline,
                maxGroupSize: group.maxGroupSize,
                stockLimit: group.stockLimit,
                minGroupPurchase: group.minGroupPurchase,
                description: group.description,
                onTap: () {
                  // Aquí puedes agregar la lógica para manejar el tap en un grupo
                },
              );
            },
          );
        },
      ),
    );
  }
}
