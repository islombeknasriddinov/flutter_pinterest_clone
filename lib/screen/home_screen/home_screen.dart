import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/items/photo_item_widget.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends MyScreen<HomeScreenViewModel, HomeScreenView> implements HomeScreenView {
  static const String ROUTE_NAME = "home_screen";

  @override
  Future<void> onRefresh() async {
    await viewModel?.refreshData();
  }

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return MasonryGridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(right: 2.5, left: 2.5),
      itemCount: viewModel?.items.length,
      itemBuilder: (_, index) {
        PhotoHome? photoHome = viewModel?.items[index];
        if (photoHome == null) return Container();

        return PhotoItemWidget(photoHome: photoHome);
      },
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }
}
