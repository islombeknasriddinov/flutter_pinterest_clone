import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/screen_manager.dart';
import 'package:flutter_pinterestclone/screen/my_screen.dart';
import 'package:flutter_pinterestclone/screen/view.dart';
import 'package:flutter_pinterestclone/view_model/view_model.dart';

class My extends State<StatefulWidget> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

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

  TransformationController transformationController = TransformationController();
  TapDownDetails _doubleTapDetails = TapDownDetails();
  late AnimationController _animationController;
  Animation<Matrix4>? _zoomAnimation;

  @override
  void onCreate() {
    super.onCreate();
    print("@@@ ${controller.hashCode}");

    transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: getVsync(),
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        transformationController.value = _zoomAnimation!.value;
      });
  }

  Matrix4 _applyZoom() {
    final tapPosition = _doubleTapDetails!.localPosition;
    final zoomed = Matrix4.identity()
      ..translate(
        -tapPosition.dx * 2,
        -tapPosition.dy * 2,
      )
      ..scale(3.0);
    return zoomed;
  }

  Matrix4 _revertZoom() => Matrix4.identity();

  TextEditingController controller = TextEditingController();

  @override
  Widget onBuildBodyWidget(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
        ),
        BackButton(
          onPressed: () {
            ScreenManager.popUpRoute(getContext());
          },
        )
        /*Hero(
          tag: arg.photoHome.id,
          child: GestureDetector(
            onDoubleTapDown: (p) => _doubleTapDetails = p,
            onDoubleTap: () {
              final newValue =
                  transformationController.value.isIdentity() ? _applyZoom() : _revertZoom();

              _zoomAnimation = Matrix4Tween(
                begin: transformationController.value,
                end: newValue,
              ).animate(CurveTween(curve: Curves.ease).animate(_animationController));
              _animationController.forward(from: 0);
            },
            child: InteractiveViewer(
              transformationController: transformationController,
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
          ),
        ),*/
      ],
    );
  }

  @override
  void onDestroy() {
    transformationController.dispose();
    _animationController.dispose();
    super.onDestroy();
  }
}
