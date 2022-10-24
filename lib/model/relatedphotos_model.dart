import 'photohome_model.dart';

class RelatedPhotos{
  var total;
  List<PhotoHome>? results;

  RelatedPhotos.fromJson(Map<String, dynamic> json){
      total = json['total'];
      results = List<PhotoHome>.from(json['results'].map((x) => PhotoHome.fromJson(x)));
  }

  Map<String, dynamic>? toJson(){
    final Map<String, dynamic> data = {};
    data['total'] = total;
    data['result'] = new List<dynamic>.from(results!.map((x) => x.toJson()));
  }

}