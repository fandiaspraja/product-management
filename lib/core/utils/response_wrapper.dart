import 'package:labamu/core/utils/serializable.dart';

class WrappedResponse<T> {
  final T? data;

  WrappedResponse({this.data});

  factory WrappedResponse.fromJson(
    dynamic json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    // kalau langsung object
    if (json is Map<String, dynamic>) {
      return WrappedResponse<T>(data: fromJsonT(json));
    }

    // fallback
    return WrappedResponse<T>(data: null);
  }
}

class WrappedListResponse<T> {
  final List<T> data;

  WrappedListResponse({required this.data});

  factory WrappedListResponse.fromJson(
    dynamic json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    if (json is List) {
      return WrappedListResponse<T>(
        data: json.map((e) => fromJsonT(e)).toList(),
      );
    }

    return WrappedListResponse<T>(data: []);
  }
}

// class WrappedResponse<T> {
//   bool status;
//   String message;
//   T? data;

//   WrappedResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory WrappedResponse.fromJson(
//     Map<String, dynamic> json,
//     Function(Map<String, dynamic>) create,
//   ) {
//     return WrappedResponse<T>(
//       status: json["status"],
//       message: json["message"],
//       data: json.containsKey("data") ? create(json["data"]) : null,
//     );
//   }
// }

// class WrappedListResponse<T extends Serializable> {
//   bool status;
//   String message;
//   List<T>? data;

//   WrappedListResponse({
//     required this.status,
//     required this.message,
//     required this.data,
//   });

//   factory WrappedListResponse.fromjson(
//     Map<String, dynamic> json,
//     Function(List<dynamic>) create,
//   ) {
//     final rawData = json["data"];
//     return WrappedListResponse(
//       status: json["status"],
//       message: json["message"],
//       data: (rawData != null && rawData is List) ? create(rawData) : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {"status": status, "message": message, "data": data};
//   }
// }

class WrappedPaginatedListResponse<T extends Serializable> {
  bool status;
  String message;
  List<T>? data;
  Map<String, dynamic>? pagination;

  WrappedPaginatedListResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory WrappedPaginatedListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final nestedData = json['data'];
    final rawDataList = nestedData['data'] as List<dynamic>;
    final rawPagination = nestedData['pagination'] as Map<String, dynamic>;

    return WrappedPaginatedListResponse(
      status: json['status'],
      message: json['message'],
      data: rawDataList.map((e) => fromJsonT(e)).toList(),
      pagination: rawPagination,
    );
  }
}
