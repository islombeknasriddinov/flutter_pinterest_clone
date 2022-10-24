import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/photohome_model.dart';

Widget itemOfPhotos(PhotoHome photoHome, BuildContext context){
  return Container(
    margin: EdgeInsets.all(2.5),
    child: Column(
      children: [
        SizedBox(
          height: 8,
        ),
        GestureDetector(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: CachedNetworkImage(
                placeholder: (context, url) =>
                    Image.asset("assets/images/notFound.jpg"),
                imageUrl: photoHome.urls!.smallS3!,
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/notFound.jpg"),
              )),
          onTap: (){
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                photoHome.description != null
                    ? SizedBox(
                    width: 140,
                    child: Text(
                      photoHome.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ))
                    : Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(15),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              photoHome
                                  .urls!
                                  .regular!))),
                )
              ],
            ),
            GestureDetector(
                onTap: () {

                },
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                ))
          ],
        ),
      ],
    ),
  );
}