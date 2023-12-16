import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/pages/home/models/categories_model.dart';
import 'package:flutter_trip_ui/app/pages/home/models/place_model.dart';
import 'package:flutter_trip_ui/app/services/place_service.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';
import 'package:go_router/go_router.dart';

class ViewAll extends StatefulWidget {
  final CategoriesModel categoryModel;
  const ViewAll({super.key, required this.categoryModel});

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  final PlaceService placeService = PlaceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.backspace,
            color: primaryColor,
            size: 20,
          ),
        ),
        title: Text(
          widget.categoryModel.title,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: primaryColor,
                fontSize: 20,
              ),
        ),
        centerTitle: true,
      ),
      body: _buildViewAllList(),
    );
  }

  FutureBuilder<Object?> _buildViewAllList() {
    return FutureBuilder(
      future: getNearbyPlacesByType(widget.categoryModel.type),
      builder: (context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          );
        }

        if (snapshot.hasError) {
          return _buildErrorSnapshot(snapshot.error.toString());
        }

        final List<PlaceModel> places = snapshot.data;

        return _buildListOfPlaces(places);
      },
    );
  }

  Column _buildListOfPlaces(List<PlaceModel> places) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                PlaceModel place = places[index];
                String assetRef =
                    place.photos != null ? place.photos![0].photoReference : "";
                return InkWell(
                  onTap: () {
                    context.push('/place-details', extra: place);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: placeService.photoReference(
                              assetRef,
                            ),
                            errorWidget: (context, url, error) {
                              return const Center(
                                child: Icon(Icons.error),
                              );
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                              alignment: Alignment.bottomLeft,
                              color: Colors.black.withOpacity(0.2),
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  height: 60,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(place.name),
                                      Text(place.vicinity),
                                    ],
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Center _buildErrorSnapshot(error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }

  Future getNearbyPlacesByType(String type) async {
    return await placeService.nearby(type);
  }
}
