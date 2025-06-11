import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?> pickwithCamera() async {
    final XFile? file = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    return file;
  }

  Future<XFile?> pickwithGallery() async {
    final XFile? file = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    return file;
  }
}
