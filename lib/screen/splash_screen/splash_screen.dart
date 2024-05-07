import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/asset_manager.dart';
import 'package:flutter_pinterestclone/screen/.base/base_screen/main_screen.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends MyScreen<SplashScreenViewModel, SplashScreenView>
    implements SplashScreenView {
  static const String ROUTE_NAME = "splash_screen";

  @override
  void onCreate() {
    super.onCreate();
    timeCounter();
  }

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          color: const Color.fromARGB(255, 223, 26, 37),
          child: Lottie.asset(AssetManager.splashScreenAnim),
        ),
      ),
    );
  }

  void timeCounter() {
    Future.delayed(const Duration(milliseconds: 300)).then((value) {
      MainScreen.replace(getContext());
    });
  }
}
