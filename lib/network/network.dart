import 'dart:convert';

import 'package:flutter_pinterestclone/network/bean/network_request.dart';
import 'package:flutter_pinterestclone/network/bean/network_response.dart';
import 'package:http/http.dart';

class Network {

  static Future<NetworkResponse> getRequest(NetworkRequest request) async {
    var uri = Uri.https(request.baseUrl, request.api, request.params);
    var data = await get(uri, headers: request.header);

    NetworkResponse response = NetworkResponse(
      uri: data.request?.url.toString(),
      api: request.api,
      requestType: data.request?.method,
      statusCode: data.statusCode,
      response: jsonDecode(data.body),
    );
    return response;
  }
}
