import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/widgets/photo_item_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends MyScreen<HomeScreenViewModel, HomeScreenView> implements HomeScreenView {
  static const String ROUTE_NAME = "home_screen";

  @override
  void onCreate() {
    super.onCreate();
  }

  @override
  Widget onBuildBodyWidget(BuildContext context, MyViewModel? model) {
    return MasonryGridView.builder(
      padding: const EdgeInsets.only(right: 5, left: 5),
      shrinkWrap: true,
      itemCount: viewModel?.items.length,
      itemBuilder: (ctx, index) {
        PhotoHome? photoHome = viewModel?.items[index];
        if (photoHome == null) return Container();

        return PhotoItemWidget(photoHome: photoHome);
      },
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }
}
