import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/my_state.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/state_builder.dart';
import 'package:flutter_pinterestclone/screen/base/state_builder/viewmodel_builder.dart';

class MyCachedNetworkImageWidget extends MyState {
  final String imageUrl;
  final Size? size;
  final String? heroTag;
  final BoxFit? imageFit;
  final BorderRadius? borderRadius;
  final Widget Function(BuildContext context, String url)? imagePlaceHolder;
  final VoidCallback? onTapImage;

  MyCachedNetworkImageWidget(this.imageUrl, {
    this.size,
    this.heroTag,
    this.imageFit,
    this.borderRadius,
    this.imagePlaceHolder,
    this.onTapImage,
  });

  late MyCachedNetworkImageViewModel viewModel;

  Widget build() {
    return MyStateBuilder.component(() => this);
  }

  @override
  void onCreate() {
    super.onCreate();
    viewModel = MyCachedNetworkImageViewModel(getVsync());

    viewModel.onCreate();
  }

  @override
  Widget onBuildWidget(BuildContext context) {
    Widget child = InteractiveViewer(
      transformationController: viewModel.transformationController,
      child: CachedNetworkImage(
        width: size?.width.round().toDouble(),
        height: size?.height.round().toDouble(),
        imageUrl: imageUrl,
        fit: imageFit,
        placeholder: imagePlaceHolder,
        errorWidget: (_, __, ___) {
          final widget = imagePlaceHolder?.call(context, __);

          if (widget != null) {
            return widget;
          }

          return Container();
        },
      ),
    );

    if (borderRadius != null) {
      child = ClipRRect(
        borderRadius: borderRadius,
        child: child,
      );
    }

    if (heroTag != null) {
      child = Hero(tag: heroTag!, child: child);
    }

    return ViewModelBuilder(
      viewModel: viewModel,
      builder: (_, model, __) {
        return GestureDetector(
          onDoubleTapDown: viewModel.onDoubleTapDown,
          onDoubleTap: viewModel.onDoubleTap,
          onTap: onTapImage,
          child: child,
        );
      },
    );
  }

  @override
  void onDestroy() {
    super.onDestroy();
    viewModel.onDestroy();
  }
}

class MyCachedNetworkImageViewModel extends ChangeNotifier {
  final TickerProvider tickerProvider;
  final TransformationController _transformationController = TransformationController();
  TapDownDetails _doubleTapDetails = TapDownDetails();
  late AnimationController _animationController;
  Animation<Matrix4>? _zoomAnimation;

  MyCachedNetworkImageViewModel(this.tickerProvider);

  void onCreate() {
    _animationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        _transformationController.value = _zoomAnimation!.value;
      });
  }

  TransformationController get transformationController => _transformationController;

  Matrix4 _applyZoom() {
    final tapPosition = _doubleTapDetails.localPosition;
    final zoomed = Matrix4.identity()
      ..translate(-tapPosition.dx * 2, -tapPosition.dy * 2)
      ..scale(3.0);
    return zoomed;
  }

  Matrix4 _revertZoom() => Matrix4.identity();

  void onDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void onDoubleTap() {
    final newValue = _transformationController.value.isIdentity() ? _applyZoom() : _revertZoom();

    _zoomAnimation = Matrix4Tween(
      begin: _transformationController.value,
      end: newValue,
    ).animate(CurveTween(curve: Curves.ease).animate(_animationController));
    _animationController.forward(from: 0);
  }

  void onDestroy() {
    _transformationController.dispose();
    _animationController.dispose();
  }
}
