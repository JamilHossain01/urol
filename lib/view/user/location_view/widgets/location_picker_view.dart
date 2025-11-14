import 'package:flutter/material.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../uitilies/app_colors.dart';

class LocationPickerModal extends StatefulWidget {
  final LatLng? initialPosition;
  final void Function(LatLng pos, String address) onLocationSelected;

  const LocationPickerModal({
    super.key,
    this.initialPosition,
    required this.onLocationSelected,
  });

  @override
  State<LocationPickerModal> createState() => _LocationPickerModalState();
}

class _LocationPickerModalState extends State<LocationPickerModal> {
  LatLng? currentPosition;
  LatLng? selectedPosition;
  String selectedAddress = '';
  AppleMapController? mapController;
  double _currentZoom = 17;
  bool isLoading = true;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Location permission denied")));
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        currentPosition = LatLng(position.latitude, position.longitude);
        selectedPosition = widget.initialPosition ?? currentPosition;
        isLoading = false;
      });

      if (selectedPosition != null) {
        _updateAddress(selectedPosition!);
      }
    } catch (e) {
      debugPrint("Failed to get location: $e");
    }
  }

  Future<void> _updateAddress(LatLng pos) async {
    try {
      final placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        setState(() {
          selectedAddress =
              "${p.street ?? ''}, ${p.subLocality ?? ''}, ${p.locality ?? ''}, ${p.administrativeArea ?? ''}";
        });
      }
    } catch (e) {
      debugPrint("Failed to get address: $e");
    }
  }

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) return;
    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty && mapController != null) {
        final loc = locations.first;
        LatLng target = LatLng(loc.latitude, loc.longitude);
        setState(() {
          selectedPosition = target;
        });

        // Move camera to the searched location with zoom 8
        mapController!.moveCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: target, zoom: 8),
        ));

        _updateAddress(target);
      }
    } catch (e) {
      debugPrint("Location search failed: $e");
    }
  }

  void _zoomIn() {
    if (mapController != null) {
      _currentZoom += 1;
      mapController!.moveCamera(CameraUpdate.zoomTo(_currentZoom));
    }
  }

  void _zoomOut() {
    if (mapController != null) {
      _currentZoom -= 1;
      mapController!.moveCamera(CameraUpdate.zoomTo(_currentZoom));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Map
                AppleMap(
                  initialCameraPosition: CameraPosition(
                    target: selectedPosition ?? currentPosition!,
                    zoom: _currentZoom,
                  ),
                  myLocationEnabled: true,
                  onMapCreated: (controller) => mapController = controller,
                  onTap: (pos) {
                    setState(() => selectedPosition = pos);
                    _updateAddress(pos);
                  },
                  annotations: {
                    if (selectedPosition != null)
                      Annotation(
                        annotationId: AnnotationId("selected"),
                        position: selectedPosition!,
                        icon: BitmapDescriptor.defaultAnnotation,
                      ),
                    if (currentPosition != null)
                      Annotation(
                        annotationId: AnnotationId("current"),
                        position: currentPosition!,
                        icon: BitmapDescriptor.defaultAnnotation,
                      ),
                  },
                  circles: {
                    if (currentPosition != null)
                      Circle(
                        circleId: CircleId("radius"),
                        center: currentPosition!,
                        radius: 100,
                        strokeColor: AppColors.mainColor.withOpacity(0.5),
                        fillColor: AppColors.mainColor.withOpacity(0.2),
                        strokeWidth: 2,
                      ),
                  },
                ),

                // Search Bar
                Positioned(
                  top: 16,
                  left: 16,
                  right: 16,
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white, // Background color
                    child: TextField(
                      controller: searchController,
                      textInputAction: TextInputAction.search,
                      onChanged: _searchLocation, // Auto search as typing
                      decoration: InputDecoration(
                        hintText: "Search location",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                      ),
                    ),
                  ),
                ),

                // Zoom buttons
                Positioned(
                  right: 16,
                  bottom: 150,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: "zoom_in",
                        mini: true,
                        backgroundColor: Colors.white,
                        onPressed: _zoomIn,
                        child: Icon(Icons.add, color: Colors.black),
                      ),
                      SizedBox(height: 10),
                      FloatingActionButton(
                        heroTag: "zoom_out",
                        mini: true,
                        backgroundColor: Colors.white,
                        onPressed: _zoomOut,
                        child: Icon(Icons.remove, color: Colors.black),
                      ),
                    ],
                  ),
                ),

                // Bottom card
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Selected Location",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Text(
                              selectedAddress.isNotEmpty
                                  ? selectedAddress
                                  : "Tap on map to select location",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 12),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mainColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: selectedPosition == null
                                  ? null
                                  : () {
                                      widget.onLocationSelected(
                                          selectedPosition!, selectedAddress);
                                    },
                              icon: Icon(Icons.check, color: Colors.white),
                              label: Text(
                                "Confirm Location",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
