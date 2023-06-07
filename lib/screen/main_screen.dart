import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  static const String ROUTE_NAME = "main_page";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final PageController _pageController = PageController();
  int currentTap = 0;

  final List<IconData> _icons = [
    Icons.person,
    Icons.sms_rounded,
    Icons.search,
    Icons.home,
  ];

  final List<Widget> _pages = [
    HomeScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    child: BottomNavigationBar(
                      currentIndex: currentTap,
                      items: getBottomNavigationBarItems(),
                      selectedIconTheme: const IconThemeData(color: Colors.black),
                      unselectedIconTheme: const IconThemeData(color: Colors.black54),
                      type: BottomNavigationBarType.shifting,
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
      ),
    );
  }

  List<BottomNavigationBarItem> getBottomNavigationBarItems() {
    List<BottomNavigationBarItem> items = [];
    for (var icon in _icons) {
      items.add(
        BottomNavigationBarItem(
          icon: Icon(icon, size: 32),
        ),
      );
    }

    return items;
  }
}
