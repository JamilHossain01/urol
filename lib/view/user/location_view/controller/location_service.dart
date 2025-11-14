import 'dart:ui';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart';

class LocationService {
  /// Get current user location
  static Future<LatLng?> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("❌ LocationService.getCurrentLocation error: $e");
      return null;
    }
  }

  /// Get LatLng from address
  static Future<LatLng?> getLatLngFromAddress(String address) async {
    try {
      final locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      print("❌ Geocoding error: $e");
    }
    return null;
  }

  /// Create a Circle for distance radius
  static Circle createDistanceCircle({
    required LatLng center,
    required double distanceInMiles,
  }) {
    return Circle(
      circleId: CircleId('radius'),
      center: center,
      radius: distanceInMiles * 1609.34, // miles to meters
      fillColor: const Color(0x8024CFA0), // semi-transparent green
      strokeColor: const Color(0xB324CFA0),
      strokeWidth: 3,
    );
  }
}
