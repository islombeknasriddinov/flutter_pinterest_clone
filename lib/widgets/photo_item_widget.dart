import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/typedef.dart';

class PhotoItemWidget extends StatelessWidget {
  PhotoHome photoHome;
  OnTapPhotoItem? onTapItem;
  OnTapPhotoItem? onTapMore;

  PhotoItemWidget({
    Key? key,
    required this.photoHome,
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
    return GestureDetector(
      child: Hero(
        tag: photoHome.id,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.0),
          child: CachedNetworkImage(
            imageUrl: photoHome.urls?.smallS3 ?? "",
            placeholder: (context, url) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(18.0),
                child: AnimatedContainer(
                  height: 200,
                  width: double.infinity,
                  color: Colors.white,
                  duration: const Duration(milliseconds: 300),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      onTap: () => onTapItem?.call(photoHome),
    );
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
