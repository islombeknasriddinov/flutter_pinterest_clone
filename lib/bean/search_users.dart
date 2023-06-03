import 'package:flutter_pinterestclone/bean/photo_home.dart';

class SearchUsers {
  final int total;
  final int totalPages;
  final List<PhotoHome> results;

  SearchUsers({
    required this.total,
    required this.totalPages,
    required this.results,
  });

  factory SearchUsers.fromJson(Map<String, dynamic> json) {
    List<PhotoHome> photoHomeList = [];

    if (json['categories'] is List) {
      List res = json['categories'] as List;
      for (var photoHome in res) {
        photoHomeList.add(photoHome);
      }
    }

    return SearchUsers(
      total: json['total'],
      totalPages: json['total_page'],
      results: photoHomeList,
    );
  }
}
