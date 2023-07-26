import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/screen/karnel/bean/message.dart';

abstract class MyViewModelImpl<V extends View> extends MyViewModel {
  final V view;
  bool _isLoading = false;
  Message? _message;

  MyViewModelImpl(this.view);

  @override
  void onCreate() {}

  @override
  bool get isLoading => _isLoading;

  @override
  Message? get message => _message;

  @override
  void resetMessage() {
    _message = null;
    notifyListeners();
  }

  @override
  void onDestroy() {}

  void setProgress(bool value) {
    _isLoading = value;
  }

  void setErrorMessage(Message newMessage) {
    _message = newMessage;
  }
}
