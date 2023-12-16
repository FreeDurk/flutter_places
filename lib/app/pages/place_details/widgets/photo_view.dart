import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/pages/home/models/photo_model.dart';
import 'package:flutter_trip_ui/app/services/place_service.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoView extends StatelessWidget {
  final List<Photo> photos;
  final int? currentTapPhoto;
  const PhotoView({super.key, required this.photos, this.currentTapPhoto});

  @override
  Widget build(BuildContext context) {
    final PlaceService placeService = PlaceService();
    return Scaffold(
        body: WillPopScope(
      child: Column(
        children: [
          Expanded(
            child: PhotoViewGallery.builder(
              itemCount: photos.length,
              builder: (context, idx) => PhotoViewGalleryPageOptions(
                initialScale: PhotoViewComputedScale.contained,
                imageProvider: CachedNetworkImageProvider(
                  placeService.photoReference(photos[idx].photoReference),
                ),
                heroAttributes: PhotoViewHeroAttributes(
                  tag: photos[idx].photoReference,
                ),
              ),
            ),
          )
        ],
      ),
      onWillPop: () async {
        return false;
      },
    ));
  }
}
