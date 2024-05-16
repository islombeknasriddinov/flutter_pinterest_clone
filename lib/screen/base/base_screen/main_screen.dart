import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/screen_manager.dart';
import 'package:flutter_pinterestclone/screen/home_screen/home_screen.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/search_screen/search_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class MainScreen<Vm extends MainScreenViewModel, V extends MainScreenView>
    extends MyScreen<Vm, V> implements MainScreenView {
  static const String ROUTE_NAME = "main_screen";

  static replace(BuildContext context) {
    ScreenManager.replaceRoute(context, ROUTE_NAME);
  }

  static const int HOME_SCREEN = 0;
  static const int SEARCH_SCREEN = 1;
  static const int MESSAGE_SCREEN = 2;
  static const int PROFILE_SCREEN = 3;

  final List<IconData> _icons = [
    CupertinoIcons.house_fill,
    CupertinoIcons.search,
    CupertinoIcons.chat_bubble_2_fill,
    CupertinoIcons.profile_circled,
  ];

  final List<Widget> _pages = [];


  @override
  void onCreate() {
    super.onCreate();
    _pages.addAll([
      HomeScreen(),
      SearchScreen(),
      Container(),
      Container(),
    ]);
  }

  @override
  void didHomePageListEnd() {

  }

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return Stack(
      children: [
        //currentPage(),
        _pages[viewModel!.currentIndex],
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: kToolbarHeight,
            margin: const EdgeInsets.only(right: 65, left: 65, bottom: 35),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: CupertinoTabBar(
                currentIndex: viewModel!.currentIndex,
                items: getBottomNavigationBarItems(),
                activeColor: Colors.black,
                inactiveColor: Colors.black54,
                onTap: (int index) {
/*                  PageStorage.of(getContext()).writeState(
                      getContext(), homeScreen,
                      identifier: ValueKey(homePageKey));*/
                  viewModel?.setCurrentIndex(index);
                },
              ),
            ),
          ),
        ),
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

/*  Widget currentPage() {
    switch (viewModel?.currentIndex) {
      case SEARCH_SCREEN:
        return searchScreen;
      case MESSAGE_SCREEN:
        return Container();
      case PROFILE_SCREEN:
        return Container();
      case HOME_SCREEN:
      default:
        return (PageStorage.of(getContext())
                .readState(getContext(), identifier: ValueKey(homePageKey)) ??
            HomeScreen()) as Widget;
    }
  }*/
}
