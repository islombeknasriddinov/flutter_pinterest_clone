import 'package:flutter/foundation.dart';

class NetworkResponse {
  final String? uri;
  final String? api;
  final int? statusCode;
  final String? requestType;
  final dynamic response;

  NetworkResponse({
    required this.uri,
    required this.api,
    required this.statusCode,
    required this.requestType,
    required this.response,
  }) {
    if (kDebugMode) {
      print(toString());
    }
  }

  String get errorText => statusCode != 200 ? response.toString() : "";

  bool get isSuccessful => statusCode == 200;

  List<dynamic> getListResponse() {
    final data = response;
    if (data is List && data.isNotEmpty) {
      return data;
    } else {
      return [];
    }
  }

  Map<String, dynamic> getMapResponse() {
    final data = response;
    if (data is Map && data.isNotEmpty) {
      return data as Map<String, dynamic>;
    } else {
      return {};
    }
  }

  @override
  String toString() {
    return [
      "*** Response ***",
      "uri: $uri",
      "api: $api",
      "status code: $statusCode",
      "request type: $requestType",
      "isSuccessful: $isSuccessful",
      if (isSuccessful != true) "error text: $errorText",
      if (isSuccessful == true) "response: $response",
      " ",
    ].join("\n");
  }
}
