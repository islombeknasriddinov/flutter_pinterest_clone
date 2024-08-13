import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/log.dart';
import 'package:flutter_pinterestclone/screen/base/base_screen/main_screen.dart';
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

    return MaterialApp(
      home: SplashScreen(),
      initialRoute: SplashScreen.ROUTE_NAME,
      routes: getRoutes(),
    );
  }

  Map<String, WidgetBuilder> getRoutes() {
    return {
      SplashScreen.ROUTE_NAME: screenBuilder(SplashScreen(), SplashScreen.ROUTE_NAME),
      MainScreen.ROUTE_NAME: screenBuilder(MainScreen(), MainScreen.ROUTE_NAME),
      SearchScreen.ROUTE_NAME: screenBuilder(SearchScreen(), SearchScreen.ROUTE_NAME),
      DetailScreen.ROUTE_NAME: screenBuilder(DetailScreen(), DetailScreen.ROUTE_NAME),
    };
  }

  WidgetBuilder screenBuilder(Widget screen, String routeName) {
    Logger.p("Opened Screen: $routeName");
    return (context) => screen;
  }
}
