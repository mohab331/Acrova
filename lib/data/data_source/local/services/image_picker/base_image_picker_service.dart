import 'package:image_picker/image_picker.dart';

/// Abstract contract for image picking, to be implemented by the data layer.
abstract class BaseImagePickerService {
  Future<XFile?> pickFromCamera();
  Future<XFile?> pickFromGallery();
  Future<List<XFile>> pickMultipleFromGallery();
  Future<String> convertXFileToBase64(XFile? image);
}
