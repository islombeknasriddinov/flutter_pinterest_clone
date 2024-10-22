import 'package:flutter_pinterestclone/common/log.dart';
import 'package:flutter_pinterestclone/screen/base/bean/message.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

abstract class MyViewModelImpl<V extends View> extends MyViewModel {
  final V view;
  bool _isLoading = false;
  Message? _message;

  MyViewModelImpl(this.view);

  @override
  void onCreate() {}

  @override
  void initListeners() {}

  @override
  bool get isLoading => _isLoading;

  @override
  Message? get message => _message;

  @override
  void resetMessage({bool notify = false}) {
    if (message != null) {
      _message = null;
      if (notify) notifyListeners();
    }
  }

  @override
  void onDestroy() {}

  void setProgress(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  @override
  void setErrorMessage(dynamic error, [dynamic st, bool notify = true]) {
    Logger.e(error, st);
    _message = Message.error(
      messageText: error.toString(),
      onTapResetMessage: () => resetMessage(),
    );
    if (notify) notifyListeners();
  }

  @override
  void setSuccessMessage(String message, {bool notify = true}) {
    _message = Message.success(
      messageText: message,
      onTapResetMessage: () => resetMessage(),
    );
    if (notify) notifyListeners();
  }

  @override
  void setInfoMessage(String message, {bool notify = true}) {
    _message = Message.info(
      messageText: message,
      onTapResetMessage: () => resetMessage(),
    );
    if (notify) notifyListeners();
  }

  @override
  void setWarningMessage(String message, {bool notify = true}) {
    _message = Message.warning(
      messageText: message,
      onTapResetMessage: () => resetMessage(),
    );
    if (notify) notifyListeners();
  }
}
