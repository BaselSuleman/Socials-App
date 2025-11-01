import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageFilePickerService {
  static ImageFilePickerService? _instance;
  final ImagePicker picker;

  ImageFilePickerService._(this.picker);

  factory ImageFilePickerService.getInstance() {
    _instance ??= ImageFilePickerService._(ImagePicker());
    return _instance!;
  }

  Future<File?> pickImageFromCamera({int? imageQuality}) async {
    final XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
    );
    if (xFile == null) return null;
    return File(xFile.path);
  }

  Future<File?> pickImageFromGallery({int? imageQuality}) async {
    final XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
    );
    if (xFile == null) return null;
    return File(xFile.path);
  }

  Future<List<File>> multipleImagesFromGallery({int? imageQuality}) async {
    final List<XFile> xFiles = await picker.pickMultiImage(
      imageQuality: imageQuality,
      limit: 2
    );

    final limitedFiles = xFiles.take(2).toList();

    return limitedFiles.map((xFile) => File(xFile.path)).toList();
  }
}
