import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:micropolis_assessment/core/utils/app_constants.dart';

@lazySingleton
class CloudinaryService {

  Future<String?> uploadImage(File file) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(file.path),
    });

    final response = await Dio().post(
      'https://api.imgbb.com/1/upload?key=b3b98fd250ecef93d9c8ec8b3a15807d',
      data: formData,
    );

    if (response.statusCode == 200) {
      return response.data['data']['url'];
    }
    return null;
  }
}
