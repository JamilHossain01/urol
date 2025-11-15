// current_location_service.dart

import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';

class CurrentLocationService {
  final GetStorage storage = GetStorage();

  /// Request location permission
  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    // Return true if granted, false if denied
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  /// Get current location
  Future<Position?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return null;

      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return pos;
    } catch (e) {
      print("Error fetching location: $e");
      return null;
    }
  }

  /// Save latitude and longitude to GetStorage
  Future<void> saveLatLong(double latitude, double longitude) async {
    await storage.write("latitude", latitude);
    await storage.write("longitude", longitude);
  }

  /// Read saved latitude
  double? get savedLat => storage.read("latitude");

  /// Read saved longitude
  double? get savedLong => storage.read("longitude");
}
