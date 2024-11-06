import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GroupPurchaseForm extends StatefulWidget {
  @override
  _GroupPurchaseFormState createState() => _GroupPurchaseFormState();
}

class _GroupPurchaseFormState extends State<GroupPurchaseForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _deadlineController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Crear Grupo de Compra para Producto', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextFormField(
              controller: _deadlineController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Fecha Límite',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                _selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (_selectedDate != null) {
                  _deadlineController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
                }
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Tamaño Máximo del Grupo'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Stock Límite'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Compra Mínima para Grupo'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implementar lógica para publicar anuncio grupal
              },
              child: Text('Publicar'),
            ),
          ],
        ),
      ),
    );
  }
}
