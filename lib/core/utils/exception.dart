import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ServerException implements Exception {}

class DatabaseException implements Exception {
  final String message;

  DatabaseException(this.message);
}

// class NoDataException implements Exception {
//   final String message;
//   NoDataException({required this.message});

//   @override
//   String toString() => 'NoDataException: $message';
// }

class NoDataException extends BaseException {
  NoDataException({required String? message})
    : super(message: message ?? "No Data Found", statusCode: 404);

  @override
  String toString() => 'NoDataException: $message';
}

class BaseException implements Exception {
  final String message;
  final int? statusCode;

  BaseException({this.statusCode, required this.message});

  factory BaseException.fromDioException(DioException e) {
    if (e.error is FormatException) {
      return BaseException(
        message: "Bad response format from server",
        statusCode: e.response?.statusCode,
      );
    }

    if (e.error is BaseException) {
      return e.error as BaseException;
    }

    if (e.error != null) {
      final data = e.error;
      if (kDebugMode) {
        print(e);
        print("===========${e.error.toString()}");
      }
      final message = data is Map<String, dynamic>
          ? data['message']
          : e.message;
      return BaseException(message: message ?? e.error.toString());
    }
    return BaseException(message: e.message ?? 'Unexpected error');
  }

  @override
  String toString() => message;
}

/// An enum that holds names for our custom exceptions.
enum _ExceptionType {
  /// The exception for an expired bearer token.
  TokenExpiredException,

  /// The exception for a prematurely cancelled request.
  CancelException,

  /// The exception for a failed connection attempt.
  ConnectTimeoutException,

  /// The exception for failing to send a request.
  SendTimeoutException,

  /// The exception for failing to receive a response.
  ReceiveTimeoutException,

  /// A better name for the socket exception.
  FetchDataException,

  /// The exception for an incorrect parameter in a request/response.
  FormatException,

  /// The exception for an unknown type of failure.
  UnrecognizedException,

  /// The exception for an unknown exception from the api.
  ApiException,

  /// The exception for any parsing failure encountered during
  /// serialization/deserialization of a request.
  SerializationException,

  NoDataException,
}
