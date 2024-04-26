import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/detail_screen/detail_screen.dart';
import 'package:flutter_pinterestclone/screen/karnel/base_screen/main_screen.dart';
import 'package:flutter_pinterestclone/screen/home_screen/home_screen.dart';
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
      routes: {
        SplashScreen.ROUTE_NAME: (context) => SplashScreen(),
        MainScreen.ROUTE_NAME: (context) => MainScreen(),
        HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
        SearchScreen.ROUTE_NAME: (context) => SearchScreen(),
        DetailScreen.ROUTE_NAME: (context) => DetailScreen(),
      },
    );
  }
}
