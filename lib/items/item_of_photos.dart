import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pinterestclone/bean/photo_home.dart';
import 'package:flutter_pinterestclone/common/asset_manager.dart';

Widget itemOfPhotos(PhotoHome photoHome, BuildContext context) {
  return Container(
    margin: const EdgeInsets.all(2.5),
    child: Column(
      children: [
        const SizedBox(height: 8),
        InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18.0),
            child: CachedNetworkImage(
              imageUrl: photoHome.urls?.smallS3 ?? "",
              placeholder: (context, url) =>
                  Image.asset(AssetManager.imageNotFound),
              errorWidget: (context, url, error) =>
                  Image.asset(AssetManager.imageNotFound),
              fadeInDuration: const Duration(microseconds: 1),
              fadeOutDuration: const Duration(microseconds: 1),
            ),
          ),
          onTap: () {},
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (photoHome.urls?.regular != null)
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        NetworkImage(photoHome.user?.profileImage?.large ?? ""),
                  ),
                ),
              ),
            const SizedBox(width: 8),
            SizedBox(
              width: 130,
              child: Text(
                photoHome.description ??
                    photoHome.altDescription ??
                    photoHome.user?.name ??
                    "",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            InkWell(
              child: const Icon(Icons.more_horiz, color: Colors.black),
              onTap: () {},
            )
          ],
        ),
      ],
    ),
  );
}
