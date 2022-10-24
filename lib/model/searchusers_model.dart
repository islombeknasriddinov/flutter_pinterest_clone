
import 'package:flutter_pinterestclone/model/photohome_model.dart';

class SearchUsers{
  var total;
  var total_pages;
  List<PhotoHome>? results;

  SearchUsers.fromJson(Map<String, dynamic> json){
    total = json['total'];
    total_pages = json['total_page'];
    results = List<PhotoHome>.from(json['results'].map((x) => PhotoHome.fromJson(x))).toList();
  }

  Map<String, dynamic>? toJson(){
    final Map<String, dynamic> data = {};
    data['total'] = total;
    data['total_page'] = total_pages;
    data['result'] = new List<dynamic>.from(results!.map((x) => x.toJson()));
  }
}