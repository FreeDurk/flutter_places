import 'dart:convert';

import 'package:flutter_trip_ui/app/pages/home/models/geometry_model.dart';
import 'package:flutter_trip_ui/app/pages/home/models/photo_model.dart';
import 'package:flutter_trip_ui/app/pages/home/models/plus_code_model.dart';

class PlaceModel {
  String? nextPageToken;
  String businessStatus;
  Geometry geometry;
  String icon;
  String iconBackgroundColor;
  String iconMaskBaseUri;
  String name;
  List<Photo>? photos;
  String placeId;
  PlusCode? plusCode;
  String rating;
  String reference;
  String scope;
  List<String> types;
  int userRatingsTotal;
  String vicinity;

  PlaceModel({
    this.nextPageToken,
    required this.businessStatus,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.name,
    required this.photos,
    required this.placeId,
    required this.plusCode,
    required this.rating,
    required this.reference,
    required this.scope,
    required this.types,
    required this.userRatingsTotal,
    required this.vicinity,
  });

  factory PlaceModel.fromRawJson(String str) =>
      PlaceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlaceModel.fromJson(Map<String, dynamic> json) => PlaceModel(
        businessStatus: json["business_status"] ?? "",
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor: json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        name: json["name"],
        photos: json["photos"] != null
            ? List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x)))
            : null,
        placeId: json["place_id"],
        plusCode: json["plus_code"] != null
            ? PlusCode.fromJson(json["plus_code"])
            : null,
        rating: json["rating"] != null ? json["rating"].toString() : "1.0",
        reference: json["reference"],
        scope: json["scope"] ?? "",
        types: List<String>.from(json["types"].map((x) => x)),
        userRatingsTotal: json["user_ratings_total"] ?? 0,
        vicinity: json["vicinity"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "business_status": businessStatus,
        "geometry": geometry.toJson(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "name": name,
        "photos": List<dynamic>.from(photos!.map((x) => x.toJson())),
        "place_id": placeId,
        "plus_code": plusCode!.toJson(),
        "rating": rating,
        "reference": reference,
        "scope": scope,
        "types": List<dynamic>.from(types.map((x) => x)),
        "user_ratings_total": userRatingsTotal,
        "vicinity": vicinity,
      };
}
