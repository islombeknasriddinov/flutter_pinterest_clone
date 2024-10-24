import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/typedef.dart';
import 'package:flutter_pinterestclone/component/my_component.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/widget/my_grid_list_view.dart';
import 'package:flutter_pinterestclone/widget/photo_item_widget.dart';

class HomePhotosComponent extends MyComponent<HomePhotosComponentViewModel, HomePhotosComponentView>
    implements HomePhotosComponentView {
  final String? photoId;
  final ScrollPhysics? physics;
  final double Function()? position;
  final OnTapPhotoItem? onTapItem;
  final VoidCallback? didEndScrollPosition;
  final void Function(double scrollOffset)? scrollOffset;

  HomePhotosComponent._({
    this.photoId,
    this.position,
    this.onTapItem,
    this.didEndScrollPosition,
    this.scrollOffset,
    this.physics,
  });

  factory HomePhotosComponent.main({
    double Function()? position,
    OnTapPhotoItem? onTapItem,
    VoidCallback? didEndScrollPosition,
    void Function(double scrollOffset)? scrollOffset,
    ScrollPhysics? physics,
  }) {
    return HomePhotosComponent._(
      position: position,
      onTapItem: onTapItem,
      didEndScrollPosition: didEndScrollPosition,
      scrollOffset: scrollOffset,
      physics: physics,
    );
  }

  factory HomePhotosComponent.related({
    required String relatedPhotoId,
    double Function()? position,
    OnTapPhotoItem? onTapItem,
    VoidCallback? didEndScrollPosition,
    void Function(double scrollOffset)? scrollOffset,
    ScrollPhysics? physics,
  }) {
    return HomePhotosComponent._(
      photoId: relatedPhotoId,
      position: position,
      onTapItem: onTapItem,
      didEndScrollPosition: didEndScrollPosition,
      scrollOffset: scrollOffset,
      physics: physics,
    );
  }

  @override
  String? getPhotoId() => photoId;

  late ScrollController controller;

  double _pos = 0;

  @override
  void onCreate() {
    super.onCreate();
    setRefreshable(true);
    controller = ScrollController();

    controller.addListener(paginationListener);

    _pos = position?.call() ?? 0;

    Future.delayed(const Duration(milliseconds: 300), () {
      if (_pos != 0) {
        controller.animateTo(
          _pos,
          duration: const Duration(milliseconds: 300),
          curve: Curves.fastLinearToSlowEaseIn,
        );
      }
    });
  }

  @override
  void viewModelListener() {
    super.viewModelListener();

    if (viewModel?.items.isNotEmpty == true) {
      setCircularBottomIndicator(true);
    } else {
      setCircularBottomIndicator(false);
    }
  }

  @override
  void onDestroy() {
    print("@@@ onDestroy widget");

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
  Future<void> onRefresh() async => viewModel?.refreshData();

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    final screenSize = MediaQuery.of(getContext()).size;

    return MyGridListView(
      controller: controller,
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      crossAxisSpacing: 8,
      mainAxisSpacing: 5,
      itemCount: viewModel!.items.length,
      physics: physics,
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      itemBuilder: (ctx, index) {
        PhotoHome photoHome = viewModel!.items[index];

        return PhotoItemWidget(
          photoHome: photoHome,
          screenWidth: screenSize.width,
          onTapItem: onTapItem,
          onTapMore: (_) {},
        );
      },
    );
  }
}
