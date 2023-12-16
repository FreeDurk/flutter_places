import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_trip_ui/app/pages/home/models/photo_model.dart';
import 'package:flutter_trip_ui/app/services/place_service.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class Gallery extends StatelessWidget {
  final List<Photo>? photos;
  const Gallery({super.key, this.photos});

  @override
  Widget build(BuildContext context) {
    final PlaceService placeService = PlaceService();

    return Scaffold(
      body: photos!.isEmpty
          ? const Center(
              child: Text("No additional images."),
            )
          : MasonryGridView.builder(
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              itemCount: photos!.length,
              itemBuilder: (context, idx) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return _buildModalPhoto(placeService, idx);
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: CachedNetworkImage(
                        imageUrl: placeService
                            .photoReference(photos![idx].photoReference),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  PhotoViewGallery _buildModalPhoto(
      PlaceService placeService, int currentPage) {
    return PhotoViewGallery.builder(
      pageController: PageController(initialPage: currentPage),
      itemCount: photos!.length,
      builder: (context, idx) => PhotoViewGalleryPageOptions(
        initialScale: PhotoViewComputedScale.contained,
        imageProvider: CachedNetworkImageProvider(
          placeService.photoReference(photos![idx].photoReference),
        ),
        heroAttributes: PhotoViewHeroAttributes(
          tag: photos![idx].photoReference,
        ),
      ),
    );
  }
}
