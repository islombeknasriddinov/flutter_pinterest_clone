import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/log.dart';
import 'package:flutter_pinterestclone/network/network_manager.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/main_viewmodel/main_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/screen/base/bean/message.dart';

class HomeScreenViewModelImpl extends MainScreenViewModelImpl<HomeScreenView>
    implements HomeScreenViewModel {
  final NetworkManager networkManager;

  final List<PhotoHome> _list = [];

  @override
  List<PhotoHome> get items => _list;

  HomeScreenViewModelImpl(HomeScreenView view, this.networkManager)
      : super(view);

  StreamSubscription<ConnectivityResult>? subscription;

  int _page = 1;

  @override
  void onCreate() {
    super.onCreate();
    _apiPhotoList(_page);

    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if ((result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) && _list.isEmpty) {
        _apiPhotoList(_page);
      }
    });
  }

  @override
  Future<void> refreshData() async {
    _list.clear();
    _page += 1;
    await _apiPhotoList(_page, withProgress: false);
    notifyListeners();
  }

  @override
  Future<void> loadData() async {
    _page += 1;
    await _apiPhotoList(_page);
  }

  Future<void> _apiPhotoList(int page, {bool withProgress = true}) async {
    try {
      resetMessage();

      final result = await Connectivity().checkConnectivity();

      if (result == ConnectivityResult.none) {
        setErrorMessage(
            Message.error(messageText: "Подключение к интернету прервано"));
        return;
      }

      if (withProgress == true) setProgress(true);

      List<PhotoHome> photoList = await networkManager.getPhotos(page: page);
      if (photoList.isNotEmpty) {
        _list.addAll(photoList);
      }
    } catch (e, st) {
      Logger.e(e, st);
      setErrorMessage(Message.error(messageText: e.toString()));
    } finally {
      if (withProgress == true) setProgress(false);
    }
  }

  @override
  void onDestroy() {
    print("@@@");
    subscription?.cancel();
    super.onDestroy();
  }
}
