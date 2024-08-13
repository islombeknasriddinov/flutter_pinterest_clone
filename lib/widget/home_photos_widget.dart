import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/typedef.dart';
import 'package:flutter_pinterestclone/widgets/photo_item_widget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePhotosWidget extends StatefulWidget {
  final List<PhotoHome> items;
  final ScrollController? controller;
  final double? position;
  final OnTapPhotoItem? onTapItem;
  final VoidCallback? didEndScrollPosition;
  final void Function(double scrollOffset)? scrollOffset;

  HomePhotosWidget({
    required this.items,
    this.controller,
    this.position,
    this.onTapItem,
    this.didEndScrollPosition,
    this.scrollOffset,
  });

  @override
  State<HomePhotosWidget> createState() => _HomePhotosWidgetState();
}

class _HomePhotosWidgetState extends State<HomePhotosWidget> {
  late ScrollController controller;
  double _pos = 0;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? ScrollController();

    controller.addListener(paginationListener);

    _pos = widget.position ?? 0;

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

  void paginationListener() async {
    widget.scrollOffset?.call(controller.offset);

    if (controller.offset == controller.position.maxScrollExtent) {
      widget.didEndScrollPosition?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      controller: controller,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      crossAxisSpacing: 8,
      mainAxisSpacing: 5,
      itemCount: widget.items.length,
      itemBuilder: (ctx, index) {
        PhotoHome photoHome = widget.items[index];

        return PhotoItemWidget(photoHome: photoHome, onTapItem: widget.onTapItem);
      },
    );
  }

  @override
  void dispose() {
    controller.removeListener(paginationListener);
    controller.dispose();
    super.dispose();
  }
}
