import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/User_viewmodel/usuarioStore_viewmodel.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  // Controladores para los campos de texto
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _groupPriceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  
  // Nuevos controladores para cantidades mínimas
  final TextEditingController _minDirectQuantityController = TextEditingController();
  final TextEditingController _minGroupQuantityController = TextEditingController();

  bool _groupEnabled = false; // Para habilitar o deshabilitar compra grupal

  @override
  Widget build(BuildContext context) {
    final usuarioViewModel = Provider.of<UsuarioViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo de texto para el nombre del producto
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Producto',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Campo de texto para la descripción
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Campo de texto para el precio
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Precio (Compra Directa)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Campo de texto para el precio grupal (solo si está habilitada la compra grupal)
              if (_groupEnabled)
                TextField(
                  controller: _groupPriceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Precio (Compra Grupal)',
                    border: OutlineInputBorder(),
                  ),
                ),
              const SizedBox(height: 16),

              // Campo de texto para el stock
              TextField(
                controller: _stockController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cantidad Disponible',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Campo de texto para la cantidad mínima de compra directa
              TextField(
                controller: _minDirectQuantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cantidad Mínima (Compra Directa)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Campo de texto para la cantidad mínima de compra grupal (solo si está habilitada)
              if (_groupEnabled)
                TextField(
                  controller: _minGroupQuantityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Cantidad Mínima (Compra Grupal)',
                    border: OutlineInputBorder(),
                  ),
                ),
              const SizedBox(height: 16),

              // Checkbox para habilitar la compra grupal
              CheckboxListTile(
                title: const Text('Habilitar Compra Grupal'),
                value: _groupEnabled,
                onChanged: (bool? value) {
                  setState(() {
                    _groupEnabled = value ?? false;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Botón para guardar el producto
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _saveProduct(usuarioViewModel);
                  },
                  child: const Text('Guardar Producto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveProduct(UsuarioViewModel usuarioViewModel) {
    final String name = _nameController.text;
    final String? email = usuarioViewModel.email;
    final String description = _descriptionController.text;
    final double price = double.tryParse(_priceController.text) ?? 0;
    final double groupPrice = _groupEnabled
        ? double.tryParse(_groupPriceController.text) ?? 0
        : 0;
    final int stock = int.tryParse(_stockController.text) ?? 0;
    final int minDirectQuantity = int.tryParse(_minDirectQuantityController.text) ?? 1; // Valor por defecto
    final int minGroupQuantity = _groupEnabled
        ? int.tryParse(_minGroupQuantityController.text) ?? 1 // Valor por defecto
        : 1; // Valor por defecto si la compra grupal no está habilitada

    if (name.isEmpty || price <= 0 || stock <= 0 || minDirectQuantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
      return;
    }

    final DateTime createdAt = DateTime.now(); // Fecha de creación actual

    // Crear el producto usando el ViewModel
    usuarioViewModel.CreateProductUser(
      '1',
      email!,
      name,
      description,
      price,
      _groupEnabled,
      stock,
      createdAt,
      minDirectQuantity, // Añadir cantidad mínima para compra directa
      minGroupQuantity,  // Añadir cantidad mínima para compra grupal
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Producto guardado exitosamente.')),
    );
  }
}
