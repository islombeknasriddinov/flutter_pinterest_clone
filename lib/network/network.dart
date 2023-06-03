import 'dart:convert';

import 'package:flutter_pinterestclone/network/bean/network_request.dart';
import 'package:flutter_pinterestclone/network/bean/network_response.dart';
import 'package:http/http.dart';

class Network {
  static const String BASE = "api.unsplash.com";
  static const String ACCESS_KEY = "Xx9ZDZTlUn7YsfX-kKUaPtIl4HfBGW50qFH1UnIJsU8";

  static Map<String, String> headers = {"Authorization": "Client-ID $ACCESS_KEY"};

  static Future<NetworkResponse> getRequest(NetworkRequest request) async {
    var uri = Uri.https(BASE, request.api, request.params);
    var data = await get(uri, headers: headers);
    NetworkResponse response = NetworkResponse(
      api: request.api,
      requestType: "GET",
      statusCode: data.statusCode,
      response: jsonDecode(data.body),
    );
    return response;
  }
}
