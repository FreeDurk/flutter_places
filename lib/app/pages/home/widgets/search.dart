import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/pages/home/models/place_model.dart';
import 'package:flutter_trip_ui/app/services/place_service.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';
import 'package:go_router/go_router.dart';

class AppSearch extends SearchDelegate<String?> {
  final String hintText;
  final TextStyle? searchTextStyle;

  AppSearch({
    required this.hintText,
    this.searchTextStyle,
  }) : super(
          searchFieldLabel: hintText,
          searchFieldStyle: searchTextStyle,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    PlaceService placeService = PlaceService();

    return FutureBuilder(
      future: placeService.textSearch(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            child: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          print(snapshot.stackTrace.toString());
          return Center(
            child: Text(
              snapshot.stackTrace.toString(),
              style: const TextStyle(color: Colors.black),
            ),
          );
        }

        List<PlaceModel>? places = snapshot.data;

        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: places!.length,
                  itemBuilder: (context, idx) {
                    PlaceModel place = places[idx];

                    final asset = place.photos?.isNotEmpty == true
                        ? placeService
                            .photoReference(place.photos![0].photoReference)
                        : "https://firebasestorage.googleapis.com/v0/b/ryde-navi.appspot.com/o/placeholder.png?alt=media&token=61f586b3-589a-4760-8b95-cb99ec4dfdd6";

                    return ListTile(
                      onTap: () {
                        context.pushNamed('place_details', extra: place);
                      },
                      leading: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor.withOpacity(0.3),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(asset),
                              fit: BoxFit.cover),
                        ),
                      ),
                      title: Text(
                        place.name,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      subtitle: Row(
                        children: [
                          Text(place.rating),
                          const SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            "assets/images/star.png",
                            height: 10,
                            width: 10,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
