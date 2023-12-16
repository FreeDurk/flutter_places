import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_trip_ui/app/pages/home/models/place_details_model.dart';
import 'package:flutter_trip_ui/app/pages/home/models/place_model.dart';
import 'package:flutter_trip_ui/app/services/location_service.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class PlaceService {
  final String googleUriAuthority = dotenv.get("GOOGLE_URI_AUTHORITY");
  final String googleApiKey = dotenv.get("GOOGLE_API_KEY");
  AppLocationService locationService = AppLocationService();

  Future<List<PlaceModel>?> textSearch(String textQuery) async {
    LocationData? myLocation = await locationService.getLocation();

    final Uri uri =
        Uri.https(googleUriAuthority, "/maps/api/place/textsearch/json", {
      'query': textQuery,
      'location': '${myLocation!.latitude},${myLocation.longitude}',
      'radius': "50000",
      'key': googleApiKey,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<PlaceModel> textSearchResult =
          (json.decode(response.body)["results"] as List)
              .map((result) => PlaceModel.fromJson(result))
              .toList();

      return textSearchResult;
    }

    return null;
  }

  Future nearby(String type) async {
    LocationData? myLocation = await locationService.getLocation();
    final Uri uri =
        Uri.https(googleUriAuthority, "/maps/api/place/nearbysearch/json", {
      'location': '${myLocation!.latitude},${myLocation.longitude}',
      'radius': "5000",
      'type': type,
      'rating': "3.0",
      'key': googleApiKey,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<PlaceModel> nearbyPlaces =
          (json.decode(response.body)["results"] as List)
              .map((place) => PlaceModel.fromJson(place))
              .toList();

      return nearbyPlaces;
    }
    return null;
  }

  Future<PlaceDetailsModel?> placeDetails(String placeId) async {
    final Uri uri =
        Uri.https(googleUriAuthority, "/maps/api/place/details/json", {
      'place_id': placeId,
      'key': googleApiKey,
    });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final PlaceDetailsModel details =
          PlaceDetailsModel.fromJson(json.decode(response.body)["result"]);

      return details;
    }

    return null;
  }

  photoReference(String photoRef) {
    final Uri uri = Uri.https(googleUriAuthority, "/maps/api/place/photo", {
      'photo_reference': photoRef,
      'maxheight': "1000",
      'maxwidth': "1000",
      'key': googleApiKey,
    });

    return uri.toString();
  }
}
