import 'package:flutter/cupertino.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';

abstract class ViewModel extends ChangeNotifier {}

abstract class MyViewModel extends ViewModel {
  void onCreate();

  void onDestroy();
}

abstract class HomeScreenViewModel extends MyViewModel {
  List<PhotoHome> get items;
}
