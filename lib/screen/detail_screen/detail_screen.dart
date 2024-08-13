import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/screen_manager.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

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

  static open<T>(BuildContext context, ArgDetailScreen arg, {Function(T result)? onPopResult}) {
    ScreenManager.openRoute(context, ROUTE_NAME, arg: arg, onPopResult: onPopResult);
  }

  ArgDetailScreen get arg => getArgument<ArgDetailScreen>()!;

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: arg.photoHome.id,
          child: CachedNetworkImage(
            imageUrl: arg.photoHome.urls?.full ?? "",
            placeholder: (ctx, widget) => CachedNetworkImage(
              imageUrl: arg.photoHome.urls?.smallS3 ?? "",
              errorWidget: (ctx, error, st) {
                viewModel?.setErrorMessage(error, st);

                return Container();
              },
            ),
          ),
        ),
      ],
    );
  }
}
