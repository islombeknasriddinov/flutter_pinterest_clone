import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/network/network_manager.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/common/log.dart';
import 'package:flutter_pinterestclone/view_model/my_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/screen/karnel/bean/message.dart';

class HomeScreenViewModelImpl extends MyViewModelImpl<HomeScreenView>
    implements HomeScreenViewModel {
  final NetworkManager networkManager;
  var subscription;

  final List<PhotoHome> _list = [];

  @override
  List<PhotoHome> get items => _list;

  HomeScreenViewModelImpl(HomeScreenView view, this.networkManager)
      : super(view);

  @override
  void onCreate() {
    super.onCreate();
    _apiPhotoList(1);

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        _apiPhotoList(1);
      }
    });
  }

  @override
  Future<void> refreshData() async {
    _list.clear();
    await _apiPhotoList(1);
    notifyListeners();
  }

  Future<void> _apiPhotoList(int page) async {
    try {
      setProgress(true);
      List<PhotoHome> photoList = await networkManager.getPhotos(page: page);
      if (photoList.isNotEmpty) {
        _list.addAll(photoList);
      }
    } catch (e, st) {
      Logger.e(e, st);
      setErrorMessage(Message.error(messageText: e.toString()));
    } finally {
      setProgress(false);
    }

    notifyListeners();
  }

  @override
  void onDestroy() {
    subscription.cancel();
    super.onDestroy();
  }
}
