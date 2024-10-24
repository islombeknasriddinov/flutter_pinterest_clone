import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/typedef.dart';
import 'package:flutter_pinterestclone/screen/base/base_screen/main_screen.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/state_builder.dart';
import 'package:flutter_pinterestclone/screen/detail_screen/detail_screen.dart';
import 'package:flutter_pinterestclone/screen/search_screen/search_screen.dart';
import 'package:flutter_pinterestclone/screen/splash_screen/splash_screen.dart';
import 'package:flutter_pinterestclone/view_model/view_model_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyPinterestApp());
}

class PinterestAppTheme {}

class PinterestAppColor {
  static final PinterestAppColor instance = PinterestAppColor._();

  PinterestAppColor._();

  Color red = const Color.fromRGBO(230, 0, 35, 1);
  Color white = const Color.fromRGBO(255, 255, 255, 1);
  Color lightGray = const Color.fromRGBO(239, 239, 239, 1);
  Color lightGray1 = const Color.fromRGBO(244, 244, 244, 1);
  Color darkGray = const Color.fromRGBO(51, 51, 51, 1);
  Color black = const Color.fromRGBO(0, 0, 0, 1);
  Color green = const Color.fromRGBO(72, 155, 84, 1.0);
  Color blue = const Color.fromRGBO(74, 155, 215, 1.0);
  Color deepOrange = const Color.fromRGBO(255, 105, 0, 1.0);
}

class MyPinterestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ViewModelProvider.init();
    final routes = getRoutes();

    return MaterialApp(
      initialRoute: routes.keys.first,
      routes: routes,
      onUnknownRoute: (RouteSettings settings) {
        throw Exception("Unsupported route: ${settings.name}");
      },
    );
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      SplashScreen.ROUTE_NAME: screenBuilder(SplashScreen.ROUTE_NAME, () => SplashScreen()),
      MainScreen.ROUTE_NAME: screenBuilder(MainScreen.ROUTE_NAME, () => MainScreen()),
      SearchScreen.ROUTE_NAME: screenBuilder(SearchScreen.ROUTE_NAME, () => SearchScreen()),
      DetailScreen.ROUTE_NAME: screenBuilder(DetailScreen.ROUTE_NAME, () => DetailScreen()),
    };
  }

  WidgetBuilder screenBuilder(String routeName, OnBuildMyState onBuildScreen) {
    return (_) => MyStateBuilder.screen(routeName, onBuildScreen);
  }
}
