import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/my_view_model.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class MainScreenViewModelImpl<T extends MainScreenView> extends MyViewModelImpl<MainScreenView>
    implements MainScreenViewModel {
  MainScreenViewModelImpl(MainScreenView view) : super(view);

  int _currentIndex = 0;

  @override
  int get currentIndex => _currentIndex;

  @override
  void setCurrentIndex(int index) {
    if (index != _currentIndex) {
      _currentIndex = index;
      notifyListeners();
    }
  }
}
