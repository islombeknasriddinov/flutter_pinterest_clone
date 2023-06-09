import 'package:flutter_pinterestclone/network/network_manager.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/home_view_model/home_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

typedef OnBlocBuilder<R, T> = R Function(T view);

class ViewModelProvider<R extends ViewModel, T extends View> {
  static final Map<Type, OnBlocBuilder<ViewModel, View>> _data = {};

  static void register(Type type, OnBlocBuilder<ViewModel, View> builder) {
    _data[type] = builder;
  }

  static NetworkManager get networkManager => NetworkManagerImpl();

  static void init() {
    register(
        HomeScreenView, (view) => HomeScreenViewModelImpl(view as HomeScreenView, networkManager));
  }

  static ViewModelProvider of(View view) {
    return ViewModelProvider._(view);
  }

  final View _view;

  ViewModelProvider._(this._view);

  R? get(Type type) {
    if (_data.containsKey(type)) {
      return _data[type]?.call(_view) as R;
    }
    throw UnsupportedError("Unsupported type=$type");
  }
}
