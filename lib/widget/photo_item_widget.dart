import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/color_util.dart';
import 'package:flutter_pinterestclone/common/typedef.dart';
import 'package:flutter_pinterestclone/widget/my_cached_network_image_widget.dart';

class PhotoItemWidget extends StatelessWidget {
  PhotoHome photoHome;
  double screenWidth;
  OnTapPhotoItem? onTapItem;
  OnTapPhotoItem? onTapMore;

  PhotoItemWidget({
    Key? key,
    required this.photoHome,
    required this.screenWidth,
    this.onTapItem,
    this.onTapMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageWidth = photoHome.width!.toDouble();
    double imageHeight = photoHome.height!.toDouble() / 2;

    double aspectRatio = imageWidth / imageHeight;

    double scalingFactor = screenWidth / imageWidth;

    double widgetWidth = imageWidth * scalingFactor;
    double widgetHeight = widgetWidth / aspectRatio;

    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildPhotoWidget(Size(widgetWidth, widgetHeight)),
              const SizedBox(height: 10),
              _buildInfosWidget(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoWidget(Size size) {
    return MyCachedNetworkImageWidget(
      photoHome,
      heroTag: photoHome.id,
      size: size,
      imageFit: BoxFit.cover,
      borderRadius: BorderRadius.circular(18.0),
      imagePlaceHolder: (context, url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(18.0),
          child: Container(
            width: size.width,
            height: size.height,
            color: ColorUtil.hexToColor(photoHome.color ?? Colors.grey.value.toString()),
          ),
        );
      },
      onTapImage: onTapItem,
    ).build();
  }

  Widget _buildInfosWidget() {
    return Row(
      children: [
        _buildProfilePhotoWidget(),
        _buildDescriptionWidget(),
        _buildMoreButtonWidget(),
      ],
    );
  }

  Widget _buildMoreButtonWidget() {
    return GestureDetector(
      onTap: () => onTapMore?.call(photoHome),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: const Icon(Icons.more_horiz, color: Colors.black54),
      ),
    );
  }

  Widget _buildDescriptionWidget() {
    String? description = photoHome.description ??
        photoHome.altDescription ??
        photoHome.user?.username ??
        photoHome.user?.firstName;

    if (description == null) return Expanded(child: Container());

    return Expanded(
      child: Text(
        description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget _buildProfilePhotoWidget() {
    final profileImage = photoHome.user?.profileImage?.medium;

    if (profileImage == null) return Container();

    return Container(
      height: 30,
      width: 30,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(profileImage),
        ),
      ),
    );
  }
}
