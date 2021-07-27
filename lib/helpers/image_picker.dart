import 'dart:io';

import 'package:image_picker/image_picker.dart';

class FilePicker {
  static Future<File> getImage() async {
    ImagePicker picker = ImagePicker();
    File _image;

    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      throw Exception('Файл не был выбран');
    }
    return _image;
  }

  static Future<File> getImageFromStorage() async {
    ImagePicker picker = ImagePicker();
    File _image;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      throw Exception('Файл не был выбран');
    }
    return _image;
  }
}
