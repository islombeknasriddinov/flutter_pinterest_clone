import 'package:flutter_pinterestclone/screen/detail_screen/detail_screen.dart';

abstract class View {}

abstract class SplashScreenView extends View {}

abstract class MainScreenView extends View {}

abstract class SearchScreenView extends View {}

abstract class DetailScreenView extends View {
  ArgDetailScreen get arg;
}
