import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/network/network_manager.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/my_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class HomeScreenViewModelImpl extends MyViewModelImpl<HomeScreenView>
    implements HomeScreenViewModel {
  final NetworkManager networkManager;

  final List<PhotoHome> _list = [];

  @override
  List<PhotoHome> get items => _list;

  HomeScreenViewModelImpl(HomeScreenView view, this.networkManager)
      : super(view);

  @override
  void onCreate() {
    super.onCreate();
    apiPhotoList(1);
  }

  void apiPhotoList(int page) async {
    try {
      setProgress(true);
      List<PhotoHome> photoHomeList =
          await networkManager.getPhotos(page: page);
      if (photoHomeList.isNotEmpty) {
        _list.addAll(photoHomeList);
      }
    } catch (e, st) {
      print("Error: $e, Stacktrace: $st");
    } finally {
      setProgress(false);
    }

    notifyListeners();
  }
}
