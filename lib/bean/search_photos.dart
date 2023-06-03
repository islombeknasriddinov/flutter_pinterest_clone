import 'package:flutter_pinterestclone/bean/photo_home.dart';

class SearchPhotos {
  int total;
  int totalPages;
  List<PhotoHome> results;

  SearchPhotos({
    required this.total,
    required this.totalPages,
    required this.results,
  });

  factory SearchPhotos.fromJson(Map<String, dynamic> json) {
    return SearchPhotos(
      total: json['total'],
      totalPages: json['total_page'],
      results: PhotoHome.photoHomeListFromJson(json['results']),
    );
  }
}
