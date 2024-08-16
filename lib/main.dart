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

  runApp(MyApp());
}

class PinterestAppTheme {}

class PinterestAppColor {}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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

  WidgetBuilder screenBuilder(String routeName, OnBuildScreen onBuildScreen) {
    return (_) => MyStateBuilder(routeName, onBuildScreen);
  }
}
