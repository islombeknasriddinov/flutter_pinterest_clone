import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/log.dart';
import 'package:flutter_pinterestclone/network/network_manager.dart';
import 'package:flutter_pinterestclone/screen/base/bean/message.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/my_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class MainScreenViewModelImpl<T extends MainScreenView> extends MyViewModelImpl<MainScreenView>
    implements MainScreenViewModel {
  final NetworkManager networkManager;

  final List<PhotoHome> _list = [];

  MainScreenViewModelImpl(MainScreenView view, this.networkManager) : super(view);

  @override
  List<PhotoHome> get items => _list;

  @override
  int get currentIndex => _currentIndex;

  @override
  double get position => _position;

  int _currentIndex = 0;
  double _position = 0;
  int _page = 1;

  StreamSubscription<ConnectivityResult>? subscription;

  @override
  void onCreate() {
    super.onCreate();

    subscription = Connectivity().onConnectivityChanged.listen((result) {
      if ((result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) &&
          _list.isEmpty) {
        _apiPhotoList(_page);
      }
    });

    _apiPhotoList(_page);
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
        setErrorMessage(Message.error(messageText: "Подключение к интернету прервано"));
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
  void setCurrentIndex(int index) {
    if (index != _currentIndex) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  @override
  void setScrollOffset(double offset) {
    print("@@@@ ${offset}");

    _position = offset;
  }

  @override
  void onDestroy() {
    subscription?.cancel();
    super.onDestroy();
  }
}
