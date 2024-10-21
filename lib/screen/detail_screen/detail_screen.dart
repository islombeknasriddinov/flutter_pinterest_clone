import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
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

  static open<T>(BuildContext context, ArgDetailScreen arg, {Function(T? result)? onPopResult}) {
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
          onPressed: () {
            print("@@@ horiz");
          },
        ),
      ],
    );
  }

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).padding.top,
          color: Colors.black,
        ),
        Container(
          color: Colors.black,
          child: MyCachedNetworkImageWidget(
            arg.photoHome,
            heroTag: arg.photoHome.id,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            imagePlaceHolder: (ctx, widget) => CachedNetworkImage(
              imageUrl: arg.photoHome.urls?.smallS3 ?? "",
              errorWidget: (ctx, error, st) {
                viewModel?.setErrorMessage(error, st);

                return Container();
              },
            ),
          ).build(),
        ),
        HomePhotosComponent.related(
          relatedPhotoId: arg.photoHome.id,
          physics: const NeverScrollableScrollPhysics(),
          onTapItem: (item) => DetailScreen.open(getContext(), ArgDetailScreen(item)),
        ),
      ],
    );
  }
}
