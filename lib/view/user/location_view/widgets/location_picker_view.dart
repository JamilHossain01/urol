import 'dart:io';
import 'package:flutter/material.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as amap;
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../uitilies/app_colors.dart';

class LocationPickerModal extends StatefulWidget {
  final void Function(double lat, double lng, String address)
  onLocationSelected;
  final double? initialLat;
  final double? initialLng;

  const LocationPickerModal({
    super.key,
    required this.onLocationSelected,
    this.initialLat,
    this.initialLng,
  });

  @override
  State<LocationPickerModal> createState() => _LocationPickerModalState();
}

class _LocationPickerModalState extends State<LocationPickerModal> {
  double? selectedLat;
  double? selectedLng;

  String selectedAddress = "";
  bool isLoading = true;

  amap.AppleMapController? appleController;
  gmap.GoogleMapController? googleController;

  double _currentZoom = 16;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getInitialLocation();
  }

  Future<void> _getInitialLocation() async {
    try {
      bool service = await Geolocator.isLocationServiceEnabled();
      if (!service) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Permission Denied")));
        return;
      }

      Position pos = await Geolocator.getCurrentPosition();

      selectedLat = widget.initialLat ?? pos.latitude;
      selectedLng = widget.initialLng ?? pos.longitude;

      isLoading = false;
      setState(() {});
      _updateAddress();
    } catch (e) {}
  }

  Future<void> _updateAddress() async {
    try {
      if (selectedLat == null || selectedLng == null) return;

      List<Placemark> marks =
      await placemarkFromCoordinates(selectedLat!, selectedLng!);

      if (marks.isNotEmpty) {
        Placemark p = marks.first;

        setState(() {
          // Format as: <Label>, Street, City, State ZIP
          selectedAddress =
          "${p.street}, ${p.locality}, ${p.administrativeArea} ${p.postalCode ?? ''}";
        });
      }
    } catch (e) {
      print("Error formatting address: $e");
    }
  }


  /// SEARCH LOCATION
  Future<void> _searchLocation(String query) async {
    if (query.trim().isEmpty) return;

    try {
      List<Location> res = await locationFromAddress(query);
      if (res.isEmpty) return;

      selectedLat = res.first.latitude;
      selectedLng = res.first.longitude;

      setState(() {});

      _moveCameraTo(selectedLat!, selectedLng!);
      _updateAddress();
    } catch (e) {}
  }

  /// MOVE CAMERA (BOTH MAPS)
  void _moveCameraTo(double lat, double lng) {
    if (Platform.isIOS && appleController != null) {
      appleController!.moveCamera(
        amap.CameraUpdate.newCameraPosition(
          amap.CameraPosition(target: amap.LatLng(lat, lng), zoom: _currentZoom),
        ),
      );
    } else if (Platform.isAndroid && googleController != null) {
      googleController!.animateCamera(
        gmap.CameraUpdate.newCameraPosition(
          gmap.CameraPosition(target: gmap.LatLng(lat, lng), zoom: _currentZoom),
        ),
      );
    }
  }

  /// ZOOM IN
  void _zoomIn() {
    setState(() => _currentZoom++);
    _moveCameraTo(selectedLat!, selectedLng!);
  }

  /// ZOOM OUT
  void _zoomOut() {
    setState(() => _currentZoom--);
    _moveCameraTo(selectedLat!, selectedLng!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          Positioned.fill(
            child: Platform.isIOS ? _buildAppleMap() : _buildGoogleMap(),
          ),

          _buildSearchBar(),

          _buildZoomButtons(),

          _buildBottomCard(),
        ],
      ),
    );
  }

  /// ---------------- APPLE MAP ----------------
  Widget _buildAppleMap() {
    return amap.AppleMap(
      initialCameraPosition: amap.CameraPosition(
        target: amap.LatLng(selectedLat!, selectedLng!),
        zoom: _currentZoom,
      ),
      onMapCreated: (c) => appleController = c,
      myLocationEnabled: true,
      onTap: (pos) {
        selectedLat = pos.latitude;
        selectedLng = pos.longitude;
        setState(() {});
        _updateAddress();
      },
      annotations: {
        amap.Annotation(
          annotationId: amap.AnnotationId("selected"),
          position: amap.LatLng(selectedLat!, selectedLng!),
        ),
      },
    );
  }

  /// ---------------- GOOGLE MAP ----------------
  Widget _buildGoogleMap() {
    return gmap.GoogleMap(
      initialCameraPosition: gmap.CameraPosition(
        target: gmap.LatLng(selectedLat!, selectedLng!),
        zoom: _currentZoom,
      ),
      onMapCreated: (c) => googleController = c,
      myLocationEnabled: true,
      markers: {
        gmap.Marker(
          markerId: gmap.MarkerId("selected"),
          position: gmap.LatLng(selectedLat!, selectedLng!),
        ),
      },
      onTap: (pos) {
        selectedLat = pos.latitude;
        selectedLng = pos.longitude;
        setState(() {});
        _updateAddress();
      },
    );
  }

  /// ---------------- SEARCH BAR ----------------
  Widget _buildSearchBar() {
    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          controller: searchController,
          onChanged: _searchLocation,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Search location",
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.all(12),
          ),
        ),
      ),
    );
  }

  /// ---------------- ZOOM BUTTONS ----------------
  Widget _buildZoomButtons() {
    return Positioned(
      right: 16,
      top: 120,
      child: Column(
        children: [
          FloatingActionButton(
            mini: true,
            backgroundColor: Colors.white,
            child: const Icon(Icons.add, color: Colors.black),
            onPressed: _zoomIn,
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            mini: true,
            backgroundColor: Colors.white,
            child: const Icon(Icons.remove, color: Colors.black),
            onPressed: _zoomOut,
          ),
        ],
      ),
    );
  }

  /// ---------------- BOTTOM CARD ----------------
  Widget _buildBottomCard() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Selected Location",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(selectedAddress.isNotEmpty ? selectedAddress : "Tap on map"),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor),
                onPressed: () {
                  widget.onLocationSelected(
                      selectedLat!, selectedLng!, selectedAddress);
                },
                child: const Text(
                  "Confirm Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
