import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/main_screen.dart';
import 'package:flutter_pinterestclone/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
      routes: {
        MainScreen.ROUTE_NAME: (context) => MainScreen(),
        HomeScreen.ROUTE_NAME: (context) => HomeScreen(),
        },
    );
  }
}
