import 'package:flutter_pinterestclone/network/network_manager.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/detail_viewmodel/detail_viewmodel.dart';
import 'package:flutter_pinterestclone/view_model/main_viewmodel/main_view_model.dart';
import 'package:flutter_pinterestclone/view_model/search_viewmodel/search_viewmodel.dart';
import 'package:flutter_pinterestclone/view_model/splash_viewmodel/splash_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

typedef OnBlocBuilder<R, T> = R Function(T view);

class ViewModelProvider<R extends ViewModel, T extends View> {
  static final Map<Type, OnBlocBuilder<ViewModel, View>> _data = {};

  static void register(Type type, OnBlocBuilder<ViewModel, View> builder) {
    _data[type] = builder;
  }

  static NetworkManager get networkManager => NetworkManagerImpl();

  static Future<void> init() async {
    register(
      SplashScreenView,
      (view) =>
          SplashScreenViewModelImpl(view as SplashScreenView, networkManager),
    );
    register(
      MainScreenView,
      (view) => MainScreenViewModelImpl(view as MainScreenView, networkManager),
    );
    register(
      SearchScreenView,
      (view) =>
          SearchScreenViewModelImpl(view as SearchScreenView, networkManager),
    );
    register(
      DetailScreenView,
      (view) =>
          DetailScreenViewModelImpl(view as DetailScreenView, networkManager),
    );
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
