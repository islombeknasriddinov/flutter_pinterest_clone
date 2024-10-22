import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/network/network_manager.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/my_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class HomePhotosComponentViewModelImpl extends MyViewModelImpl<HomePhotosComponentView>
    implements HomePhotosComponentViewModel {
  final NetworkManager networkManager;

  final List<PhotoHome> _list = [];

  HomePhotosComponentViewModelImpl(HomePhotosComponentView view, this.networkManager) : super(view);

  @override
  List<PhotoHome> get items => _list;

  int _page = 1;

  StreamSubscription<ConnectivityResult>? subscription;

  @override
  void onCreate() {
    super.onCreate();

/*    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if ((result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) &&
          _list.isEmpty) {
        _apiPhotoList(_page);
      }
    });*/

    initData();
  }

  @override
  void initData() {
    final photoId = view.getPhotoId();

    if (photoId?.isNotEmpty == true) {
      loadRelatedPhotos(photoId!);
    } else {
      _apiPhotoList(_page);
    }
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
        setErrorMessage("Подключение к интернету прервано");
        return;
      }

      if (withProgress == true) setProgress(true);

      List<PhotoHome> photoList = await networkManager.getPhotos(page: page);
      if (photoList.isNotEmpty) {
        _list.addAll(photoList);
      }
    } catch (e, st) {
      setErrorMessage(e, st);
    } finally {
      if (withProgress == true) setProgress(false);
    }
  }

  Future<void> loadRelatedPhotos(String photoId, {bool withProgress = true}) async {
    try {
      resetMessage();

      final result = await Connectivity().checkConnectivity();

      if (result == ConnectivityResult.none) {
        setErrorMessage("Подключение к интернету прервано");
        return;
      }

      if (withProgress == true) setProgress(true);

      List<PhotoHome> photoList =
          await networkManager.getRelatedPhotos(photoId).then((value) => value.results);
      if (photoList.isNotEmpty) {
        _list.addAll(photoList);
      }
    } catch (e, st) {
      setErrorMessage(e, st);
    } finally {
      if (withProgress == true) setProgress(false);
    }
  }

  @override
  void onDestroy() {
    subscription?.cancel();
    super.onDestroy();
  }
}
