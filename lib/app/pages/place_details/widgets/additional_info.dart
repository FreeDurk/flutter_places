import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/pages/home/models/place_model.dart';
import 'package:flutter_trip_ui/app/pages/place_details/widgets/middle_icon.dart';
import 'package:flutter_trip_ui/app/services/location_service.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';
import 'package:latlong2/latlong.dart';

class AdditionalInfo extends StatelessWidget {
  final PlaceModel place;
  final Widget? description;
  final Widget? reviewButton;
  const AdditionalInfo(
      {super.key, required this.place, this.description, this.reviewButton});

  _convertRating(int totalRating) {
    final converted = totalRating / 1000.0;
    return "${converted.toStringAsFixed(2)}k";
  }

  Future _calculateDistance() async {
    AppLocationService locationService = AppLocationService();
    LatLng destination =
        LatLng(place.geometry.location.lat, place.geometry.location.lng);
    return locationService.calculateDistance(destination);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 22),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MiddleIcon(
                img: "assets/images/star.png",
                title: "Rating",
                subTitle:
                    "${place.rating} (${_convertRating(place.userRatingsTotal)})",
              ),
              FutureBuilder(
                future: _calculateDistance(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }
                  return MiddleIcon(
                    img: "assets/images/distance.png",
                    title: "Distance",
                    subTitle: '${snapshot.data.toString()} Km',
                  );
                },
              ),
              const MiddleIcon(
                img: "assets/images/time.png",
                title: "Duration",
                subTitle: "5 H",
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          _buildDescription(),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  _buildDescription() {
    if (description != null) {
      return description;
    }

    return const SizedBox.shrink();
  }
}
