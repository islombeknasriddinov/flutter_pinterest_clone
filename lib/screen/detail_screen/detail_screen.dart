import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/extention.dart';
import 'package:flutter_pinterestclone/common/screen_manager.dart';
import 'package:flutter_pinterestclone/component/home_component/home_photos_component.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';
import 'package:flutter_pinterestclone/widget/my_cached_network_image_widget.dart';

class ArgDetailScreen extends MyArgument {
  static const String ARG_DETAIL = "arg_detail";

  @override
  String get argKey => ArgDetailScreen.ARG_DETAIL;

  final PhotoHome photoHome;

  ArgDetailScreen(this.photoHome);
}

class DetailScreen extends MyScreen<DetailScreenViewModel, DetailScreenView>
    implements DetailScreenView {
  static const String ROUTE_NAME = "detail_screen";

  static void open<T>(
    BuildContext context,
    ArgDetailScreen arg, {
    Function(T? result)? onPopResult,
  }) {
    ScreenManager.openRoute(context, ROUTE_NAME, arg: arg, onPopResult: onPopResult);
  }

  @override
  ArgDetailScreen get arg => getArgument<ArgDetailScreen>()!;

  @override
  void onCreate() {
    super.onCreate();
    setBackgroundColor(Colors.white);
    setWithSafeArea(false);
    setScrollable(true);
    setCircularBottomIndicator(true);
    setExtendBodyBehindAppBar(true);
  }

  @override
  PreferredSizeWidget? buildAppBarWidget(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: true,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.more_horiz, size: 24, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    final widgetSize = arg.photoHome.getWidgetSize(context.getScreenWidth());

    double widgetWidth = widgetSize.width;
    double widgetHeight = widgetSize.height;

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: Colors.black,
          ),
          Container(
            color: Colors.black,
            child: MyCachedNetworkImageWidget(
              arg.photoHome.urls?.full ?? "",
              heroTag: arg.photoHome.heroTag,
              width: widgetWidth,
              height: widgetHeight,
              zoomEnabled: true,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              imagePlaceHolder: (ctx, widget) => MyCachedNetworkImageWidget(
                arg.photoHome.urls?.smallS3 ?? "",
                width: widgetWidth,
                height: widgetHeight,
                imageFit: BoxFit.cover,
              ).build(),
            ).build(),
          ),
          HomePhotosComponent.related(
            relatedPhotoId: arg.photoHome.id,
            physics: const NeverScrollableScrollPhysics(),
            onTapItem: (item) => DetailScreen.open(getContext(), ArgDetailScreen(item)),
          ),
        ],
      ),
    );
  }
}
