import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/base_screen/main_screen.dart';
import 'package:flutter_pinterestclone/screen/home_screen/home_screen.dart';
import 'package:flutter_pinterestclone/view_model/view_model_provider.dart';

void main() {
  ViewModelProvider.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      routes: {
        MainScreen.ROUTE_NAME: (context) => MainScreen(),
        HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
      },
    );
  }
}
