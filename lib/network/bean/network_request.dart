import 'package:flutter/foundation.dart';

class NetworkRequest {
  final String baseUrl;
  final Map<String, String> header;
  final String api;
  final Map<String, dynamic> _params = {};

  NetworkRequest(this.baseUrl, this.header, this.api){
    if (kDebugMode) {
      print(toString());
    }
  }

  NetworkRequest addParams(Map<String, dynamic> params) {
    _params.addAll(params);
    return this;
  }

  Map<String, dynamic> get params => _params;

  @override
  String toString(){
    return [
      "*** Request ***",
      "api: $api",
      "headrs: $header",
      "params: $params",
      " ",
    ].join("\n");
  }
}
