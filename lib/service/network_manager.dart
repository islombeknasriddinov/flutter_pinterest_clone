import 'dart:convert';

import 'package:flutter_pinterestclone/model/searchphotos_model.dart';
import 'package:flutter_pinterestclone/model/searchusers_model.dart';
import 'package:http/http.dart';
import '../model/photohome_model.dart';
import '../model/relatedphotos_model.dart';
import '../model/topic_model.dart';

class NetworkManager {
  /* http Api */
  static const String API_PHOTOS = "/photos";
  static const String API_SEARCH_PHOTOS = "/search/photos";
  static const String API_SEARCH_USERS = "/search/users";
  static const String API_TOPIC = "/topics";

  static String API_RELATED(String id) => "/photos/$id/related";

  /* https requests */
  Future<List<PhotoHome>> getPhotos({required int page}) async {
    final params = {
      'page': "$page",
      'per_page': "20",
    };
    var response = await Network.getRequest(api: API_PHOTOS, params: params);
    if (response.statusCode == 200) {
      return PhotoHome.photoHomeListFromJson(response.body);
    } else {
      throw response.body;
    }
  }

  static Future<String> getRelatedPhotos(String api) async {
    var response = await Network.getRequest(api: api);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw response.body;
    }
  }

  static Future<String> getSearchPhotos(String api, Map<String, String> params) async {
    var response = await Network.getRequest(api: api, params: params);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw response.body;
    }
  }

  static Future<String> getSearchUsers(String api, Map<String, String> params) async {
    var response = await Network.getRequest(api: api, params: params);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw response.body;
    }
  }

  static Future<String> getTopic(String api, Map<String, String> params) async {
    var response = await Network.getRequest(api: api, params: params);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw response.body;
    }
  }

  /* http params */

  static Map<String, String> paramsSearchPhotos(String page, String query) {
    Map<String, String> params = {'page': page, 'query': query, 'per_page': '20'};
    return params;
  }

  static Map<String, String> paramsSearchUsers(String page, String query) {
    Map<String, String> params = {'page': page, 'query': query, 'per_page': '20'};
    return params;
  }

  static Map<String, String> paramsTopic(String page, String perPage) {
    Map<String, String> params = {'page': page, 'per_page': perPage};
    return params;
  }

  static Map<String, String> paramsGetTopic(String page) {
    Map<String, String> params = {'page': page, 'per_page': "20"};
    return params;
  }

  /* https parsing */

  static List<PhotoHome> parseRelatesPhotos(String response) {
    dynamic json = jsonDecode(response);
    var data = RelatedPhotos.fromJson(json);
    return data.results ?? [];
  }

  static List<PhotoHome> parseSearchPhotos(String response){
    dynamic json = jsonDecode(response);
    var data = SearchPhotos.fromJson(json);
    return data.results ?? [];
  }

  static List<PhotoHome> parseSearchUsers(String response){
    dynamic json = jsonDecode(response);
    var data = SearchUsers.fromJson(json);
    return data.results ?? [];
  }

  static List<Topic> parseTopic(String response) {
    var data = topicFromJson(response);
    return data;
  }
}

class Network {
  static const String BASE = "api.unsplash.com";
  static const String ACCESS_KEY = "Xx9ZDZTlUn7YsfX-kKUaPtIl4HfBGW50qFH1UnIJsU8";

  static Map<String, String> headers = {"Authorization": "Client-ID $ACCESS_KEY"};

  static Future<Response> getRequest({
    required String api,
    Map<String, dynamic>? params,
  }) async {
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    return response;
  }
}