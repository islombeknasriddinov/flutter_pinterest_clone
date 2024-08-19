import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/common/screen_manager.dart';
import 'package:flutter_pinterestclone/screen/detail_screen/detail_screen.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/widget/home_photos_widget.dart';

class MainScreen<Vm extends MainScreenViewModel, V extends MainScreenView> extends MyScreen<Vm, V>
    implements MainScreenView {
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

  @override
  void onCreate() {
    super.onCreate();
    setRefreshable(true);
    setBackgroundColor(Colors.white);
    setCircularBottomIndicator(true);
    setWithSafeArea(false);
  }

  @override
  Future<void> onRefresh() => viewModel!.refreshData();

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return Stack(
      children: [
        currentPage(),
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

  Widget currentPage() {
    switch (viewModel?.currentIndex) {
      case SEARCH_SCREEN:
        return Container();
      case MESSAGE_SCREEN:
        return Container();
      case PROFILE_SCREEN:
        return Container();
      case HOME_SCREEN:
      default:
        return HomePhotosWidget(
          items: viewModel?.items ?? [],
          controller: ScrollController(),
          position: viewModel?.position ?? 0,
          didEndScrollPosition: () async => await viewModel?.loadData(),
          scrollOffset: (offset) => viewModel?.setScrollOffset(offset),
          onTapItem: (item) => DetailScreen.open(getContext(), ArgDetailScreen(item)),
        );
    }
  }
}
