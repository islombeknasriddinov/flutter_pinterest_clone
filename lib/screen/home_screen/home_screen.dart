import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/screen/.base/base_screen/main_screen.dart';
import 'package:flutter_pinterestclone/screen/detail_screen/detail_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/widgets/photo_item_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends MainScreen<HomeScreenViewModel, HomeScreenView>
    implements HomeScreenView {
  static const String ROUTE_NAME = "home_screen";

  final ScrollController _controller = ScrollController();

  @override
  void onCreate() {
    super.onCreate();
    setRefreshable(true);
    setBackgroundColor(Colors.white);

    _controller.addListener(paginationListener);
  }

  void paginationListener() async {
    if (_controller.offset == _controller.position.maxScrollExtent) {
      await viewModel?.loadData();
    }
  }

  @override
  Future<void> onRefresh() => viewModel!.refreshData();

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      controller: _controller,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      crossAxisSpacing: 8,
      mainAxisSpacing: 5,
      itemCount: viewModel?.items.length,
      itemBuilder: (ctx, index) {
        PhotoHome? photoHome = viewModel?.items[index];
        if (photoHome == null) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: const EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }

        return PhotoItemWidget(
          photoHome: photoHome,
          onTapItem: (photoHome) => DetailScreen.open(
            getContext(),
            ArgDetailScreen(photoHome),
          ),
        );
      },
    );
  }

  @override
  void onDestroy() {
    //_controller.removeListener(paginationListener);
    super.onDestroy();
  }
}
