import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/typedef.dart';
import 'package:flutter_pinterestclone/component/my_component.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/widgets/photo_item_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePhotosComponent extends MyComponent<HomePhotosComponentViewModel, HomePhotosComponentView>
    implements HomePhotosComponentView {
  final ScrollController controller;
  final double? position;
  final OnTapPhotoItem? onTapItem;
  final VoidCallback? didEndScrollPosition;
  final void Function(double scrollOffset)? scrollOffset;

  HomePhotosComponent({
    ScrollController? controller,
    this.position,
    this.onTapItem,
    this.didEndScrollPosition,
    this.scrollOffset,
  }) : controller = controller ?? ScrollController();

  double _pos = 0;

  @override
  void onCreate() {
    super.onCreate();
    setWithSafeArea(false);
    controller.addListener(paginationListener);

    _pos = position ?? 0;

    Future.delayed(const Duration(milliseconds: 300), () {
      if (_pos != 0) {
        controller.animateTo(
          _pos,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onDestroy() {
    controller.removeListener(paginationListener);
    controller.dispose();
    super.onDestroy();
  }

  void paginationListener() async {
    scrollOffset?.call(controller.offset);

    if (controller.offset == controller.position.maxScrollExtent) {
      viewModel?.loadData();
    }
  }

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      controller: controller,
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      crossAxisSpacing: 8,
      mainAxisSpacing: 5,
      itemCount: viewModel!.items.length,
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        PhotoHome photoHome = viewModel!.items[index];

        return PhotoItemWidget(photoHome: photoHome, onTapItem: onTapItem);
      },
    );
  }
}
