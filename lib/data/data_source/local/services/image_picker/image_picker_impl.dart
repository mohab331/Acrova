import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'base_image_picker_service.dart';

class ImagePickerServiceImpl implements BaseImagePickerService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<XFile?> pickFromCamera() =>
      _picker.pickImage(source: ImageSource.camera);

  @override
  Future<XFile?> pickFromGallery() =>
      _picker.pickImage(source: ImageSource.gallery);

  @override
  Future<List<XFile>> pickMultipleFromGallery() => _picker.pickMultiImage();

  @override
  Future<String> convertXFileToBase64(XFile? image) async {
    if (image == null) return '';
    final bytes = await File(image.path).readAsBytes();
    return base64Encode(bytes);
  }

  Future<List<String>> convertImagesToStrings(List<XFile> images) async {
    final List<String> imageStrings = [];
    for (var image in images) {
      final base64Str = await convertXFileToBase64(image);
      imageStrings.add(base64Str);
    }
    return imageStrings;
  }
}
