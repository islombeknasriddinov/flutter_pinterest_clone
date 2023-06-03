import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/home_page.dart';
import 'package:flutter_pinterestclone/screen/main_page.dart';

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
      home: HomePage(),
      routes: {HomePage.id: (context) => HomePage(), MainPage.id: (context) => MainPage()},
    );
  }
}
