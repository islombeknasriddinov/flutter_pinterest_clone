
import 'package:flutter_pinterestclone/model/photohome_model.dart';

class SearchPhotos{
  var total;
  var total_pages;
  List<PhotoHome>? results;

  SearchPhotos.fromJson(Map<String, dynamic> json){
    total = json['total'];
    total_pages = json['total_page'];
    results = List<PhotoHome>.from(json['results'].map((x) => PhotoHome.fromJson(x)));
  }
}