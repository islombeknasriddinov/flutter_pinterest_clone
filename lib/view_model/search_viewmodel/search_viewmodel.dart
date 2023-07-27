import 'package:flutter_pinterestclone/network/network_manager.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/my_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class SearchScreenViewModelImpl extends MyViewModelImpl<SearchScreenView>
    implements SearchScreenViewModel {
  final NetworkManager _networkManager;

  SearchScreenViewModelImpl(SearchScreenView view, this._networkManager) : super(view);

  @override
  void onCreate() {
    super.onCreate();
  }


}
