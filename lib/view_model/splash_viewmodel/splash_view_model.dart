import 'package:flutter_pinterestclone/network/network_manager.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/my_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class SplashScreenViewModelImpl extends MyViewModelImpl<SplashScreenView>
    implements SplashScreenViewModel {
  final NetworkManager _networkManager;

  SplashScreenViewModelImpl(SplashScreenView view, this._networkManager)
      : super(view);

  @override
  void onCreate() {
    super.onCreate();
  }
}
