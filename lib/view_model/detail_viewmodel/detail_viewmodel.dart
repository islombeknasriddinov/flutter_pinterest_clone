import 'package:flutter_pinterestclone/network/network_manager.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/my_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class DetailScreenViewModelImpl extends MyViewModelImpl<DetailScreenView>
    implements DetailScreenViewModel {
  final NetworkManager networkManager;

  DetailScreenViewModelImpl(DetailScreenView view, this.networkManager)
      : super(view);


}
