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

    loadRelatedPhotos();
  }

  Future<void> loadRelatedPhotos({bool withProgress = true}) async {
    try {
      resetMessage();

      final result = await Connectivity().checkConnectivity();

      if (result == ConnectivityResult.none) {
        setErrorMessage("Подключение к интернету прервано");
        return;
      }

      if (withProgress == true) setProgress(true);

      List<PhotoHome> photoList = await networkManager
          .getRelatedPhotos(view.arg.photoHome.id)
          .then((value) => value.results);
      if (photoList.isNotEmpty) {
        _relatedPhotos.addAll(photoList);
      }
    } catch (e, st) {
      Logger.e(e, st);
      setErrorMessage(e, st);
    } finally {
      if (withProgress == true) setProgress(false);
    }
  }
}
