import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/service/network_manager.dart';

import '../model/photohome_model.dart';

class MainViewModel extends ChangeNotifier{
  final NetworkManager networkManager = NetworkManager();
  bool isLoading = false;
  List<PhotoHome> items = [];

  void apiPhotoList(int page) async {
    try {
      isLoading = true;
      notifyListeners();

      List<PhotoHome> photoHomeList = await networkManager.getPhotos(page: page);
      if (photoHomeList.isNotEmpty) {
        items = photoHomeList;
        notifyListeners();
      }
    } catch (e, st) {
      print("Error: $e, Stacktrace: $st");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}