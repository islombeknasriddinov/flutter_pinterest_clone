import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/screen_manager.dart';
import 'package:flutter_pinterestclone/component/home_component/home_photos_component.dart';
import 'package:flutter_pinterestclone/screen/detail_screen/detail_screen.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class MainScreen extends MyScreen<MainScreenViewModel, MainScreenView> implements MainScreenView {
  static const String ROUTE_NAME = "main_screen";

  static replace(BuildContext context) {
    ScreenManager.replaceRoute(context, ROUTE_NAME);
  }

  final List<IconData> _icons = [
    CupertinoIcons.house_fill,
    CupertinoIcons.search,
    CupertinoIcons.chat_bubble_2_fill,
    CupertinoIcons.profile_circled,
  ];

  final List<Widget> myComponents = [];

  ScrollController get controller => ScrollController();

  @override
  void onCreate() {
    super.onCreate();
    setRefreshable(true);
    setBackgroundColor(Colors.white);
    setCircularBottomIndicator(true);
    setWithSafeArea(false);

    myComponents.addAll(
      [
        HomePhotosComponent.main(
          position: () => viewModel?.position ?? 0,
          scrollOffset: (offset) => viewModel?.setScrollOffset(offset),
          onTapItem: (item) => DetailScreen.open(getContext(), ArgDetailScreen(item)),
        ).build(),
        Container(),
        Container(),
        Container(),
      ],
    );
  }

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return Stack(
      children: [
        myComponents[viewModel?.currentIndex ?? 0],
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: kToolbarHeight,
            margin: const EdgeInsets.only(right: 65, left: 65, bottom: 35),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: CupertinoTabBar(
                currentIndex: viewModel!.currentIndex,
                items: getBottomNavigationBarItems(),
                activeColor: Colors.black,
                inactiveColor: Colors.black54,
                onTap: (int index) {
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
}
