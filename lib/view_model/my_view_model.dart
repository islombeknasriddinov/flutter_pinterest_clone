import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

abstract class MyViewModelImpl<V extends View> extends MyViewModel {
  final V view;
  bool _isLoading = false;

  MyViewModelImpl(this.view);

  @override
  void onCreate() {}

  @override
  bool get isLoading => _isLoading;

  @override
  void onDestroy() {}

  void setProgress(bool value) {
    _isLoading = value;
  }
}
