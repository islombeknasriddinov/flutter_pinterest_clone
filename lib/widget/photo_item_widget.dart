import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/color_util.dart';
import 'package:flutter_pinterestclone/common/extention.dart';
import 'package:flutter_pinterestclone/common/typedef.dart';
import 'package:flutter_pinterestclone/widget/my_cached_network_image_widget.dart';

class PhotoItemWidget extends StatelessWidget {
  final PhotoHome photoHome;
  final double? width;
  final double? height;
  final OnTapPhotoItem? onTapItem;
  final OnTapPhotoItem? onTapMore;

  PhotoItemWidget({
    Key? key,
    required this.photoHome,
    this.height,
    this.width,
    this.onTapItem,
    this.onTapMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildPhotoWidget(),
          const SizedBox(height: 10),
          _buildInfosWidget(),
        ],
      ),
    );
  }

  Widget _buildPhotoWidget() {
    return MyCachedNetworkImageWidget(
      photoHome.urls?.smallS3 ?? photoHome.urls?.small ?? "",
      heroTag: photoHome.heroTag,
      height: height,
      width: width,
      imageFit: BoxFit.cover,
      borderRadius: BorderRadius.circular(18.0),
      imagePlaceHolder: (context, url) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(18.0),
          child: Container(
            width: width,
            height: height,
            color: ColorUtil.hexToColor(photoHome.color ?? Colors.grey.value.toString()),
          ),
        );
      },
      onTapImage: () => onTapItem?.call(photoHome),
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
