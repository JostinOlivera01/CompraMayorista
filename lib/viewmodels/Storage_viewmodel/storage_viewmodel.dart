import 'dart:io';
import 'package:flutter/material.dart';
import 'package:test01/business_logic/actions/User_actions/storage_actions.dart';

class ImageViewModel extends ChangeNotifier {
  final ImageActions imageActions;

  ImageViewModel(this.imageActions);

  bool _isUploading = false;
  bool get isUploading => _isUploading;

  String? _uploadedImageUrl;
  String? get uploadedImageUrl => _uploadedImageUrl;

  Future<void> uploadImage(File imageFile, String folderPath) async {
    _isUploading = true;
    _uploadedImageUrl = null;
    notifyListeners();

    try {
      print("data02");

      _uploadedImageUrl = await imageActions.uploadImage(imageFile, folderPath);
      print("data01");
      notifyListeners();
    } catch (e) {
      print('Error en ImageViewModel: $e');
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }
}
