import 'dart:convert';

import 'package:flutter_pinterestclone/model/searchphotos_model.dart';
import 'package:flutter_pinterestclone/model/searchusers_model.dart';
import 'package:http/http.dart';
import '../model/photohome_model.dart';
import '../model/relatedphotos_model.dart';
import '../model/topic_model.dart';

class Network{
  static final String BASE = "api.unsplash.com";
  static final String ACCESS_KEY = "Xx9ZDZTlUn7YsfX-kKUaPtIl4HfBGW50qFH1UnIJsU8";
  static final String CLIENT_ID = "Client-ID";

  static Map<String, String> headers = {"Authorization": "$CLIENT_ID $ACCESS_KEY" };

  /* http Api */
  static String API_PHOTOS = "/photos";
  static String API_RELATED(String id) => "/photos/$id/related";
  static String API_SEARCH_PHOTOS = "/search/photos";
  static String API_SEARCH_USERS = "/search/users";
  static String API_TOPIC = "/topics";

  /* http requests */
  static Future<String?> getPhotos(String api, Map<String, String> params) async{
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  static Future<String?> getRelatedPhotos(String api) async{
    var uri = Uri.https(BASE, api);
    var response = await get(uri, headers: headers);
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  static Future<String?> getSearchPhotos(String api, Map<String, String> params) async{
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  static Future<String?> getSearchUsers(String api, Map<String, String> params) async{
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  static Future<String?> getTopic(String api, Map<String, String> params) async{
    var uri = Uri.https(BASE, api, params);
    var response = await get(uri, headers: headers);
    print(response.body);
    if(response.statusCode == 200){
      return response.body;
    }
    return null;
  }

  /* http params */

  static Map<String, String> paramsGetPhotos(String page){
    Map<String, String> params = new Map();
    params.addAll({
      'page':page,
      'per_page':"20"
    });
    return params;
  }

  static Map<String, String> paramsSearchPhotos(String page, String query){
    Map<String, String> params = new Map();
    params.addAll({
      'page':page,
      'query': query,
      'per_page': '20'
    });
    return params;
  }

  static Map<String, String> paramsSearchUsers(String page, String query){
    Map<String, String> params = new Map();
    params.addAll({
      'page':page,
      'query': query,
      'per_page': '20'
    });
    return params;
  }

  static Map<String, String> paramsTopic(String page, String per_page){
    Map<String, String> params = new Map();
    params.addAll({
      'page':page,
      'per_page':per_page
    });
    return params;
  }

  static Map<String, String> paramsGetTopic(String page){
    Map<String, String> params = new Map();
    params.addAll({
      'page':page,
      'per_page':"20"
    });
    return params;
  }

  /* https parsing */
  static List<PhotoHome> parsePhotoHome(String response){
    var data = pinterestFromJson(response);
    return data;
  }

  static List<PhotoHome> parseRelatesPhotos(String response){
    dynamic json = jsonDecode(response);
    var data = RelatedPhotos.fromJson(json);
    return data.results!;
  }

  static List<PhotoHome> parseSearchPhotos(String response){
    dynamic json = jsonDecode(response);
    var data = SearchPhotos.fromJson(json);
    return data.results!;
  }

  static List<PhotoHome> parseSearchUsers(String response){
    dynamic json = jsonDecode(response);
    var data = SearchUsers.fromJson(json);
    return data.results!;
  }

  static List<Topic> parseTopic(String response){
    var data = topicFromJson(response);
    return data;
  }
}