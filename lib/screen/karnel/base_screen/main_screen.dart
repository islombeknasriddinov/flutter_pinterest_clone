import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/screen_manager.dart';
import 'package:flutter_pinterestclone/screen/home_screen/home_screen.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class MainScreen extends MyScreen<MainScreenViewModel, MainScreenView> implements MainScreenView {
  static const String ROUTE_NAME = "main_screen";

  static replace(BuildContext context) {
    ScreenManager.replaceRoute(context, ROUTE_NAME);
  }

  final PageController _pageController = PageController();
  int currentTap = 0;

  final List<IconData> _icons = [
    Icons.home,
    Icons.sms_rounded,
    Icons.search,
    Icons.person,
  ];

  final List<Widget> _pages = [
    HomeScreen(),
  ];

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return Stack(
      children: [
        PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (int index) {
            currentTap = index;
          },
          children: _pages,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 55,
                margin: const EdgeInsets.only(right: 65, left: 65, bottom: 35),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  child: CupertinoTabBar(
                    currentIndex: currentTap,
                    items: getBottomNavigationBarItems(),
                    activeColor: Colors.black,
                    inactiveColor: Colors.black54,
                    onTap: (int index) {
                      currentTap = index;
                      _pageController.jumpToPage(index);
                    },
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  List<BottomNavigationBarItem> getBottomNavigationBarItems() {
    List<BottomNavigationBarItem> items = [];
    for (var icon in _icons) {
      items.add(BottomNavigationBarItem(icon: Icon(icon, size: 24)));
    }

    return items;
  }
}
