import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/asset_manager.dart';
import 'package:flutter_pinterestclone/screen/base/base_screen/main_screen.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends MyScreen<SplashScreenViewModel, SplashScreenView>
    implements SplashScreenView {
  static const String ROUTE_NAME = "splash_screen";

  AnimationController? controller;

  @override
  void onCreate() {
    super.onCreate();
    setWithSafeArea(false);
    setExtendBodyBehindAppBar(true);
    controller = AnimationController(
      vsync: getVsync(),
      duration: const Duration(seconds: 3),
    );

    controller?.addStatusListener(statusListener);
  }

  void statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {}
  }

  @override
  PreferredSizeWidget? buildAppBarWidget(BuildContext context) {
    return AppBar(backgroundColor: color.red, primary: false, elevation: 0);
  }

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: color.red,
          child: Lottie.asset(
            AssetManager.splashScreenAnim,
            controller: controller,
            repeat: false,
            onLoaded: (composition) {
              controller!
                ..duration = composition.duration
                ..forward().whenComplete(() => MainScreen.replace(getContext()));
            },
          ),
        ),
      ),
    );
  }

  @override
  void onDestroy() {
    controller?.removeStatusListener(statusListener);
    controller?.dispose();
    super.onDestroy();
  }
}
