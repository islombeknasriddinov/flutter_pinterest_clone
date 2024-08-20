import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/log.dart';
import 'package:flutter_pinterestclone/network/network_manager.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/my_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class MainScreenViewModelImpl extends MyViewModelImpl<MainScreenView>
    implements MainScreenViewModel {
  final NetworkManager networkManager;

  MainScreenViewModelImpl(MainScreenView view, this.networkManager) : super(view);

  @override
  int get currentIndex => _currentIndex;

  @override
  double get position => _position;

  int _currentIndex = 0;
  double _position = 0;

  @override
  void setCurrentIndex(int index) {
    if (index != _currentIndex) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  @override
  void setScrollOffset(double offset) {
    _position = offset;
  }
}
