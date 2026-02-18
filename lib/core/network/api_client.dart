import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:labamu/core/network/api_constants.dart';
import 'package:labamu/core/network/request_interceptor.dart';
import 'package:labamu/core/utils/exception.dart';

class ApiClient {
  final Dio dio;
  final RequestInterceptor requestInterceptor;

  // ApiClient({required String baseUrl})
  //     : dio = Dio(BaseOptions(baseUrl: baseUrl)) {
  //   // You can configure Dio here (e.g., interceptors)
  //   dio.interceptors.add(LogInterceptor(responseBody: true));
  // }

  ApiClient(this.dio, this.requestInterceptor) {
    // Configure Dio base options
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      // connectTimeout: const Duration(milliseconds: 5000),
      // receiveTimeout: const Duration(milliseconds: 3000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    dio.interceptors.add(requestInterceptor);
    dio.interceptors.add(ChuckerDioInterceptor());
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw BaseException.fromDioException(e);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await dio.post(path, data: data, queryParameters: query);
      return response;
    } on DioException catch (e) {
      throw BaseException.fromDioException(e);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }

  Future<Response> postFormData(String path, {dynamic data}) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        options: Options(
          contentType: data is FormData
              ? 'multipart/form-data'
              : 'application/json',
        ),
      );
      return response;
    } on DioException catch (e) {
      throw BaseException.fromDioException(e);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }

  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      throw BaseException.fromDioException(e);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await dio.delete(path, data: data);
      return response;
    } on DioException catch (e) {
      throw BaseException.fromDioException(e);
    } on Exception catch (e) {
      throw BaseException(message: e.toString());
    }
  }
}
