import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/my_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class MainScreenViewModelImpl<T extends MainScreenView>
    extends MyViewModelImpl<MainScreenView> implements MainScreenViewModel {
  MainScreenViewModelImpl(MainScreenView view) : super(view);

  int _currentIndex = 0;

  final ScrollController _homePageListController = ScrollController();

  @override
  int get currentIndex => _currentIndex;

  @override
  ScrollController get homePageListController => _homePageListController;

  @override
  void onCreate() {
    super.onCreate();
    _homePageListController.addListener(paginationListener);
  }

  void paginationListener() async {
    print("paginationListener");
    if (_homePageListController.offset ==
        _homePageListController.position.maxScrollExtent) {
      print("didHomePageListEnd");
      view.didHomePageListEnd();
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
  void onDestroy() {
    super.onDestroy();
  }
}
