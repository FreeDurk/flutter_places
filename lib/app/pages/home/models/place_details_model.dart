import 'dart:convert';

import 'package:flutter_trip_ui/app/pages/home/models/geometry_model.dart';
import 'package:flutter_trip_ui/app/pages/home/models/photo_model.dart';
import 'package:flutter_trip_ui/app/pages/home/models/plus_code_model.dart';

class PlaceDetailsModel {
  List<AddressComponent> addressComponents;
  String adrAddress;
  String businessStatus;
  EditorialSummary? editorialSummary;
  String formattedAddress;
  String formattedPhoneNumber;
  Geometry geometry;
  String icon;
  String iconBackgroundColor;
  String iconMaskBaseUri;
  String internationalPhoneNumber;
  String name;
  List<Photo> photos;
  String placeId;
  PlusCode? plusCode;
  double rating;
  String reference;
  List<Review> reviews;
  List<String> types;
  String url;
  int userRatingsTotal;
  int utcOffset;
  String vicinity;
  String website;
  bool wheelchairAccessibleEntrance;

  PlaceDetailsModel({
    required this.addressComponents,
    required this.adrAddress,
    required this.businessStatus,
    this.editorialSummary,
    required this.formattedAddress,
    required this.formattedPhoneNumber,
    required this.geometry,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconMaskBaseUri,
    required this.internationalPhoneNumber,
    required this.name,
    required this.photos,
    required this.placeId,
    this.plusCode,
    required this.rating,
    required this.reference,
    required this.reviews,
    required this.types,
    required this.url,
    required this.userRatingsTotal,
    required this.utcOffset,
    required this.vicinity,
    required this.website,
    required this.wheelchairAccessibleEntrance,
  });

  factory PlaceDetailsModel.fromRawJson(String str) =>
      PlaceDetailsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) =>
      PlaceDetailsModel(
        addressComponents: List<AddressComponent>.from(
            json["address_components"]
                .map((x) => AddressComponent.fromJson(x))),
        adrAddress: json["adr_address"],
        businessStatus: json["business_status"] ?? "",
        editorialSummary: json["editorial_summary"] != null
            ? EditorialSummary.fromJson(json["editorial_summary"])
            : null,
        formattedAddress: json["formatted_address"],
        formattedPhoneNumber: json["formatted_phone_number"] ?? "",
        geometry: Geometry.fromJson(json["geometry"]),
        icon: json["icon"],
        iconBackgroundColor: json["icon_background_color"],
        iconMaskBaseUri: json["icon_mask_base_uri"],
        internationalPhoneNumber: json["international_phone_number"] ?? "",
        name: json["name"],
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        placeId: json["place_id"],
        plusCode: json["plus_code"] != null
            ? PlusCode.fromJson(json["plus_code"])
            : null,
        rating: json["rating"]?.toDouble(),
        reference: json["reference"],
        reviews: json["reviews"] != null
            ? List<Review>.from(json["reviews"].map((x) => Review.fromJson(x)))
            : [],
        types: List<String>.from(json["types"].map((x) => x)),
        url: json["url"],
        userRatingsTotal: json["user_ratings_total"],
        utcOffset: json["utc_offset"],
        vicinity: json["vicinity"],
        website: json["website"] ?? "",
        wheelchairAccessibleEntrance:
            json["wheelchair_accessible_entrance"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "address_components":
            List<dynamic>.from(addressComponents.map((x) => x.toJson())),
        "adr_address": adrAddress,
        "business_status": businessStatus,
        "editorial_summary": editorialSummary?.toJson(),
        "formatted_address": formattedAddress,
        "formatted_phone_number": formattedPhoneNumber,
        "geometry": geometry.toJson(),
        "icon": icon,
        "icon_background_color": iconBackgroundColor,
        "icon_mask_base_uri": iconMaskBaseUri,
        "international_phone_number": internationalPhoneNumber,
        "name": name,
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "place_id": placeId,
        "plus_code": plusCode?.toJson(),
        "rating": rating,
        "reference": reference,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "types": List<dynamic>.from(types.map((x) => x)),
        "url": url,
        "user_ratings_total": userRatingsTotal,
        "utc_offset": utcOffset,
        "vicinity": vicinity,
        "website": website,
        "wheelchair_accessible_entrance": wheelchairAccessibleEntrance,
      };
}

class AddressComponent {
  String longName;
  String shortName;
  List<String> types;

  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromRawJson(String str) =>
      AddressComponent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddressComponent.fromJson(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json["long_name"],
        shortName: json["short_name"],
        types: List<String>.from(json["types"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "long_name": longName,
        "short_name": shortName,
        "types": List<dynamic>.from(types.map((x) => x)),
      };
}

class EditorialSummary {
  String language;
  String overview;

  EditorialSummary({
    required this.language,
    required this.overview,
  });

  factory EditorialSummary.fromRawJson(String str) =>
      EditorialSummary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EditorialSummary.fromJson(Map<String, dynamic> json) =>
      EditorialSummary(
        language: json["language"],
        overview: json["overview"],
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "overview": overview,
      };
}

class Review {
  String authorName;
  String authorUrl;
  String language;
  String originalLanguage;
  String profilePhotoUrl;
  int rating;
  String relativeTimeDescription;
  String text;
  int time;
  bool translated;

  Review({
    required this.authorName,
    required this.authorUrl,
    required this.language,
    required this.originalLanguage,
    required this.profilePhotoUrl,
    required this.rating,
    required this.relativeTimeDescription,
    required this.text,
    required this.time,
    required this.translated,
  });

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        authorName: json["author_name"],
        authorUrl: json["author_url"],
        language: json["language"] ?? "",
        originalLanguage: json["original_language"] ?? "",
        profilePhotoUrl: json["profile_photo_url"],
        rating: json["rating"],
        relativeTimeDescription: json["relative_time_description"],
        text: json["text"],
        time: json["time"],
        translated: json["translated"],
      );

  Map<String, dynamic> toJson() => {
        "author_name": authorName,
        "author_url": authorUrl,
        "language": language,
        "original_language": originalLanguage,
        "profile_photo_url": profilePhotoUrl,
        "rating": rating,
        "relative_time_description": relativeTimeDescription,
        "text": text,
        "time": time,
        "translated": translated,
      };
}
