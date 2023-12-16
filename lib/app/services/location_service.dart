import 'dart:async';
import 'dart:math';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppLocationService {
  final String? googleApiKey = dotenv.env['GOOGLE_API_KEY'];
  final Location location = Location();
  LocationData? locationData;

  LocationData? get myLocation => locationData;
  StreamController<LocationData> locationStreamController =
      StreamController<LocationData>.broadcast();
  late StreamSubscription<LocationData> locationSubscription;

  Stream<LocationData> get locationStream => locationStreamController.stream;

  onChange() {
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 3000,
      distanceFilter: 200,
    );
    return location.onLocationChanged;
  }

  locationChange() {
    locationSubscription = location.onLocationChanged.listen(
      (LocationData currentLocation) {
        locationStreamController.add(currentLocation);
      },
    );
  }

  Future<Map<String, dynamic>> checkService() async {
    bool isLocationServiceEnabled;
    PermissionStatus permissionGranted;
    isLocationServiceEnabled = await location.serviceEnabled();

    if (!isLocationServiceEnabled) {
      isLocationServiceEnabled = await location.requestService();

      if (!isLocationServiceEnabled) {
        return {"locationService": false};
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();

      if (permissionGranted != PermissionStatus.granted) {
        return {"permission": false};
      }
    }

    return {"locationService": true};
  }

  Future<LocationData?> getLocation() async {
    return await location.getLocation();
  }

  Future<String> calculateDistance(LatLng point2) async {
    LocationData? myLocation = await getLocation();
    const double radiusOfEarth = 6371.0; // Earth's radius in kilometers

    double lat1 = _degreesToRadians(myLocation!.latitude!.toDouble());
    double lon1 = _degreesToRadians(myLocation.longitude!.toDouble());
    double lat2 = _degreesToRadians(point2.latitude);
    double lon2 = _degreesToRadians(point2.longitude);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = radiusOfEarth * c;
    return distance.toStringAsFixed(2);
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180.0;
  }
}
