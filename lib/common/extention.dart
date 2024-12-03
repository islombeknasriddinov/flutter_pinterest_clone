import 'package:flutter/cupertino.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/my_state.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/state_builder.dart';

extension MyContextExtension on BuildContext {
  MediaQueryData getMediaQuery() => MediaQuery.of(this);

  Size getScreenSize() => getMediaQuery().size;

  bool isDeviceTablet() => getScreenSize().shortestSide >= 600;

  double getScreenWidth() => getScreenSize().width;

  double getScreenHeight() => getScreenSize().height;
}

extension MyStateExtension on MyState {
  Widget build() => MyStateBuilder.build(() => this);
}
