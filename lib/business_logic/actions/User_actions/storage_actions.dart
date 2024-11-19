import 'dart:io';
import 'package:test01/business_logic/service/storageService.dart';

class ImageActions {
  final StorageService storageService;

  ImageActions(this.storageService);

  Future<String> uploadImage(File imageFile, String folderPath) async {
    try {
      return await storageService.uploadImage(imageFile, folderPath);
    } catch (e) {
      throw Exception('Error en ImageActions: $e');
    }
  }
}
