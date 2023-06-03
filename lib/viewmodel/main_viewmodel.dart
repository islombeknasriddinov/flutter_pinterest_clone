import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/network/network_manager.dart';

class MainViewModel extends ChangeNotifier {
  final NetworkManager networkManager;
  bool isLoading = false;
  List<PhotoHome> items = [];

  MainViewModel(this.networkManager);

  void apiPhotoList(int page) async {
    try {
      isLoading = true;

      List<PhotoHome> photoHomeList = await networkManager.getPhotos(page: page);
      if (photoHomeList.isNotEmpty) {
        items.addAll(photoHomeList);
      }
    } catch (e, st) {
      print("Error: $e, Stacktrace: $st");
    } finally {
      isLoading = false;
    }
    notifyListeners();
  }
}
