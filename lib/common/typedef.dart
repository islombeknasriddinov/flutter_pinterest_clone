import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/my_state.dart';

typedef OnTapPhotoItem = void Function(PhotoHome photoHome);

typedef OnBuildMyState = MyState Function();

typedef OnSetErrorMessage = void Function(dynamic error, [dynamic st]);
