import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

abstract class MyViewModelImpl<V extends View> extends MyViewModel{
  final V view;

  MyViewModelImpl(this.view);

  @override
  void onCreate() {}

  @override
  void onDestroy() {}
}

