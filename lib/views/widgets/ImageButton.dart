import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test01/viewmodels/Storage_viewmodel/storage_viewmodel.dart';



class ImageUploadButton extends StatefulWidget {
  final String folderPath;
  final Function(String) onImageUploaded; // Callback para devolver la URL

  const ImageUploadButton({super.key, required this.folderPath, required this.onImageUploaded});

  @override
  _ImageUploadButtonState createState() => _ImageUploadButtonState();
}

class _ImageUploadButtonState extends State<ImageUploadButton> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage(BuildContext context) async {
    if (_selectedImage == null) return;

    final imageViewModel = Provider.of<ImageViewModel>(context, listen: false);
    await imageViewModel.uploadImage(_selectedImage!, widget.folderPath);

    if (imageViewModel.uploadedImageUrl != null) {
      widget.onImageUploaded(imageViewModel.uploadedImageUrl!); // Llamamos al callback con la URL
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageViewModel = Provider.of<ImageViewModel>(context);

    return Column(
      children: [
        if (_selectedImage != null)
          Image.file(
            _selectedImage!,
            width: 150,
            height: 150,
            fit: BoxFit.cover,
          ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: imageViewModel.isUploading ? null : _pickImage,
          child: const Text('Seleccionar Imagen'),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: imageViewModel.isUploading ? null : () => _uploadImage(context),
          child: imageViewModel.isUploading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('Subir Imagen'),
        ),
      ],
    );
  }
}
