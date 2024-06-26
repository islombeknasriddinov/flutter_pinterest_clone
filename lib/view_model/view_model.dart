import 'package:flutter/cupertino.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/screen/base/bean/message.dart';

abstract class ViewModel extends ChangeNotifier {}

abstract class MyViewModel extends ViewModel {
  void onCreate();

  bool get isLoading;

  Message? get message;

  void resetMessage();

  void onDestroy();

  void setErrorMessage(Message newMessage);
}

abstract class SplashScreenViewModel extends MyViewModel {}

abstract class MainScreenViewModel extends MyViewModel {

  int get currentIndex;

  ScrollController get homePageListController;

  void setCurrentIndex(int index);
}

abstract class HomeScreenViewModel extends MainScreenViewModel {
  List<PhotoHome> get items;

  Future<void> loadData();

  Future<void> refreshData();
}

abstract class SearchScreenViewModel extends MyViewModel {}

abstract class DetailScreenViewModel extends MyViewModel {}
