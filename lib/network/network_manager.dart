import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/bean/related_photos.dart';
import 'package:flutter_pinterestclone/network/bean/network_request.dart';
import 'package:flutter_pinterestclone/network/network.dart';

abstract class NetworkManager {
  Future<List<PhotoHome>> getPhotos({required int page});

  Future<RelatedPhotos> getRelatedPhotos(String id);
}

class NetworkManagerImpl implements NetworkManager {
  static const String API_PHOTOS = "/photos";
  static const String API_SEARCH_PHOTOS = "/search/photos";
  static const String API_SEARCH_USERS = "/search/users";
  static const String API_TOPIC = "/topics";

  static String API_RELATED(String id) => "/photos/$id/related";

  @override
  Future<List<PhotoHome>> getPhotos({required int page}) async {
    NetworkRequest request = NetworkRequest(API_PHOTOS);
    request.addParams({
      'page': "$page",
      'per_page': "20",
    });
    var response = await Network.getRequest(request);
    if (response.isSuccessful) {
      return response.getListResponse().map((e) => PhotoHome.fromJson(e)).toList();
    } else {
      throw response.errorText;
    }
  }

  @override
  Future<RelatedPhotos> getRelatedPhotos(String id) async {
    NetworkRequest request = NetworkRequest(API_RELATED(id));
    var response = await Network.getRequest(request);
    if (response.isSuccessful) {
      return RelatedPhotos.fromJson(response.getMapResponse());
    } else {
      throw response.errorText;
    }
  }

/*  static Future<String> getSearchPhotos(String page, String query) async {
    final params = {
      'page': page,
      'query': query,
      'per_page': '20',
    };
    var response = await Network.getRequest(api: API_SEARCH_PHOTOS, params: params);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw response.body;
    }
  }*/

/*  static Future<String> getSearchUsers(String api, Map<String, String> params) async {
    var response = await Network.getRequest(api: api, params: params);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw response.body;
    }
  }*/

/*  static Future<String> getTopic(String api, Map<String, String> params) async {
    var response = await Network.getRequest(api: api, params: params);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw response.body;
    }
  }*/

/* http params */

/*  static Map<String, String> paramsSearchUsers(String page, String query) {
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
  }*/

/* https parsing */

/*  static List<PhotoHome> parseSearchPhotos(String response) {
    dynamic json = jsonDecode(response);
    var data = SearchPhotos.fromJson(json);
    return data.results ?? [];
  }

  static List<PhotoHome> parseSearchUsers(String response) {
    dynamic json = jsonDecode(response);
    var data = SearchUsers.fromJson(json);
    return data.results ?? [];
  }

  static List<Topic> parseTopic(String response) {
    var data = topicFromJson(response);
    return data;
  }*/
}
