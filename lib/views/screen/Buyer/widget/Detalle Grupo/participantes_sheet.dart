import 'package:flutter/material.dart';
import 'package:test01/business_logic/models/members_model.dart';

class SideDrawerExample extends StatelessWidget {
  final List<IntegranteModel> participantes;

  const SideDrawerExample({super.key, required this.participantes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Purchase'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Abre el drawer lateral
          },
          child: const Text('Abrir Participantes'),
        ),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Participantesfdsf',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: participantes.length,
                itemBuilder: (context, index) {
                  final integrante = participantes[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/vector-premium/circulo-usuario-circulo-gradiente-azul_78370-4727.jpg?w=740' ?? 'https://via.placeholder.com/100',
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
      ),
    );
  }
}
