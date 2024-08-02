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

  void initListeners();

  void setErrorMessage(Message newMessage);
}

abstract class SplashScreenViewModel extends MyViewModel {}

abstract class MainScreenViewModel extends MyViewModel {
  List<PhotoHome> get items;

  int get currentIndex;

  double get position;

  Future<void> loadData();

  Future<void> refreshData();

  void setCurrentIndex(int index);

  void setScrollOffset(double index);
}

abstract class HomeScreenViewModel extends MainScreenViewModel {

}

abstract class SearchScreenViewModel extends MyViewModel {}

abstract class DetailScreenViewModel extends MyViewModel {}
