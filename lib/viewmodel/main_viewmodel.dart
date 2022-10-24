import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/service/network_service.dart';

import '../model/photohome_model.dart';

class MainViewModel extends ChangeNotifier{
  bool isLoading = false;
  List<PhotoHome> items = [];

  void apiPhotoList(int page) async{
    isLoading = true;
    notifyListeners();

    var response = await Network.getPhotos(Network.API_PHOTOS, Network.paramsGetPhotos(page.toString()));
    if(response != null){
      items = Network.parsePhotoHome(response);
    }else{
      items = [];
    }

    isLoading = false;
    notifyListeners();
  }
}