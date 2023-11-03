import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:shimmer/shimmer.dart';

class PhotoItemWidget extends StatelessWidget {
  PhotoHome photoHome;
  void Function(PhotoHome photoHome)? onItemTab;
  void Function()? onTabMoreButton;

  PhotoItemWidget({
    required this.photoHome,
    this.onItemTab,
    this.onTabMoreButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: Column(
        children: [
          InkWell(
            onTap: onItemTab != null ? () => onItemTab!.call(photoHome) : null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: CachedNetworkImage(
                imageUrl: photoHome.urls?.smallS3 ?? "",
                placeholder: (_, __) => _placeHolderWidget(photoHome.color),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (photoHome.urls?.regular != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: CachedNetworkImage(
                    imageUrl: photoHome.user?.profileImage?.large ?? "",
                    placeholder: (_, __) => _placeHolderWidget(photoHome.color),
                    height: 30,
                    width: 30,
                  ),
                ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  photoHome.description ?? photoHome.altDescription ?? photoHome.user?.name ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              InkWell(
                onTap: onTabMoreButton != null ? () => onTabMoreButton!.call() : null,
                child: const Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                  size: 22,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _placeHolderWidget(String? color) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Color(
        (int.tryParse(color?.substring(1, 7) ?? "", radix: 16) ?? Colors.grey.value) + 0xFF000000,
      ),
    );
  }
}
