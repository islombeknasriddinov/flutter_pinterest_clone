import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/log.dart';
import 'package:flutter_pinterestclone/network/network_manager.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/my_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class DetailScreenViewModelImpl extends MyViewModelImpl<DetailScreenView>
    implements DetailScreenViewModel {
  final NetworkManager networkManager;

  final List<PhotoHome> _relatedPhotos = [];

  DetailScreenViewModelImpl(DetailScreenView view, this.networkManager) : super(view);

  @override
  List<PhotoHome> get relatedPhotos => _relatedPhotos;

  @override
  void onCreate() {
    super.onCreate();
  }
}
