import 'dart:typed_data';
import 'package:dio/dio.dart';

class UploadPictureService {
  final Dio _dio;

  UploadPictureService({Dio? dio}) : _dio = dio ?? Dio();

  Future<Response> uploadPicture({
    required Uint8List? file,
    required String type,
  }) async {
    const String url = 'https://api.atssolutionco.com/api/v2/upload/file';

    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        file!,
        filename: '$type.jpg',
      ),
      'type': type,
    });

    try {
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
        ),
      );

      return response;
    } on DioException catch (e) {
      throw Exception('Failed to upload picture: ${e.message}');
    }
  }
}
