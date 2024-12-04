import 'package:flutter/material.dart';

class ZoomViewWidget extends StatefulWidget {
  final Widget child;
  final double minScale;
  final double maxScale;
  final double? height;
  final double? width;
  final GestureScaleEndCallback? onScaleEnd;
  final GestureScaleUpdateCallback? onScaleUpdate;
  final GestureScaleStartCallback? onScaleStart;
  final VoidCallback? onTap;

  const ZoomViewWidget({
    Key? key,
    required this.child,
    this.minScale = 1.0,
    this.maxScale = 3.0,
    this.height,
    this.width,
    this.onScaleEnd,
    this.onScaleUpdate,
    this.onScaleStart,
    this.onTap,
  }) : super(key: key);

  @override
  _ZoomViewWidgetState createState() => _ZoomViewWidgetState();
}

class _ZoomViewWidgetState extends State<ZoomViewWidget> with TickerProviderStateMixin {
  late final TransformationController _transformationController;
  late final AnimationController _animationController;
  Animation<Matrix4>? _zoomAnimation;

  TapDownDetails? _doubleTapDetails;
  double scale = 1.0;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.addListener(initListener);
  }

  void initListener() {
    _transformationController.value = _zoomAnimation?.value ?? Matrix4.identity();
  }

  void onScaleStart(ScaleStartDetails details) {
    scale = _transformationController.value.getMaxScaleOnAxis();
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    final newScale = (scale * details.scale).clamp(widget.minScale, widget.maxScale);
    final currentMatrix = _transformationController.value;

    final updatedMatrix = Matrix4.identity()
      ..scale(newScale)
      ..setTranslation(currentMatrix.getTranslation());
    _startZoomAnimation(updatedMatrix);
  }

  void onDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void handleDoubleTap() {
    if (_transformationController.value.isIdentity()) {
      _zoomIn();
    } else {
      _zoomOut();
    }
  }

  void _zoomIn() {
    final position = _doubleTapDetails?.localPosition ?? Offset.zero;
    final targetScale = widget.maxScale;

    final zoomMatrix = Matrix4.identity();
    zoomMatrix.translate(-position.dx * (targetScale - 1), -position.dy * (targetScale - 1));
    zoomMatrix.scale(targetScale);

    _startZoomAnimation(zoomMatrix);
  }

  void _zoomOut() {
    _startZoomAnimation(Matrix4.identity());
  }

  void _startZoomAnimation(Matrix4 targetMatrix) {
    _zoomAnimation = Matrix4Tween(
      begin: _transformationController.value,
      end: targetMatrix,
    ).animate(CurveTween(curve: Curves.easeInOut).animate(_animationController));

    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: onDoubleTapDown,
      onDoubleTap: handleDoubleTap,
      onScaleStart: onScaleStart,
      onScaleUpdate: onScaleUpdate,
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        child: InteractiveViewer(
          transformationController: _transformationController,
          minScale: widget.minScale,
          maxScale: widget.maxScale,
          panEnabled: true,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.removeListener(initListener);
    _animationController.dispose();
    _transformationController.dispose();
    super.dispose();
  }
}
