import 'photo_home.dart';

class RelatedPhotos {
  int total;
  List<PhotoHome> results;

  RelatedPhotos({required this.total, required this.results});

  factory RelatedPhotos.fromJson(Map<String, dynamic> json) {
    return RelatedPhotos(
      total: json['total'],
      results: (json["results"] as List<dynamic>).map((e) => PhotoHome.fromJson(e)).toList(),
    );
  }
}
