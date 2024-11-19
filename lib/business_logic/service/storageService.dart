import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File imageFile, String folderPath) async {
    try {
    // Instancia de FirebaseStorage
    FirebaseStorage storage = FirebaseStorage.instance;

    // URL base de tu bucket de Firebase Storage
    Reference storageRef = storage.refFromURL("gs://compras-mayoristas.firebasestorage.app");
    
    // Generar un nombre único para el archivo
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Referencia al archivo específico
    Reference pathReference = storageRef.child('images/$fileName');

    print("Iniciando carga de imagen...");
    // Verificar que el archivo exista en la ruta proporcionada
    if (!imageFile.existsSync()) {
      throw Exception('El archivo no existe en la ruta local: ${imageFile.path}');
    }
    print("Archivo encontrado en: ${imageFile.path}");

    // Iniciar la subida del archivo
    await pathReference.putFile(imageFile);
    // Obtener la URL de descarga del archivo
    final String downloadUrl = await pathReference.getDownloadURL();
    print("URL de descarga generada: $downloadUrl");
    return downloadUrl;
    } catch (e) {
      print("Error inesperado al subir la imagen: $e");
      throw Exception('Error inesperado: $e');
    }
  }
}
