import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../local_storage/shared_preferences/shared_preferences_helper.dart';
import '../utils/exception.dart';

class RequestInterceptor extends Interceptor {
  final SharedPreferencesHelper pref;

  RequestInterceptor({required this.pref});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    EasyLoading.show();
    if (pref.getToken() != null) {
      String token = "Bearer ${pref.getToken()}";
      options.headers["Authorization"] = token;
    }
    options.headers["Accept"] = "application/json";
    options.followRedirects = false;
    options.validateStatus = (status) {
      return status! < 500;
    };
    if (Get.locale?.languageCode != null) {
      options.queryParameters["lang"] = Get.locale?.languageCode;
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    EasyLoading.dismiss();
    var error = BaseException.fromDioException(err);
    if (kDebugMode) {
      final uri = err.response?.realUri ?? err.requestOptions.uri;
      log('RESPONSE[${err.response?.data}] => REQ: $uri');
      print("=== Dio Error Occured ===");
      print(error.message);
    }

    String errorMessage = error.message;
    if (error.statusCode == 401 || errorMessage == 'Unauthenticated') {
      logout();
    }
    // consider to remap this error to generic error.
    return super.onError(err, handler);
  }

  @override
  void onResponse(dio.Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      log('RESPONSE[${response.data}] => REQ: ${response.requestOptions.uri}');
    }
    EasyLoading.dismiss();
    final statusCode = (response.data is Map)
        ? (response.data['code'] ?? response.statusCode)
        : response.statusCode;

    if (statusCode == 200 || statusCode == 201) {
      // Handle success
      return super.onResponse(response, handler);
    } else if (statusCode == 400 || statusCode == 404) {
      // Handle failure
      var message = (response.data is Map)
          ? (response.data['message'] ?? 'Request failed')
          : 'Request failed';
      throw BaseException(message: message, statusCode: statusCode);
    } else {
      // Handle unexpected custom status codes
      throw Exception('Unexpected custom status code: $statusCode');
    }
  }

  void logout() {
    pref.removeUserData();
  }
}
