// ignore_for_file: prefer_const_constructors

import 'package:calebshirthum/common widget/custom_button_widget.dart';
import 'package:calebshirthum/view/user/location_view/controller/all_map_gym_controller.dart';
import 'package:calebshirthum/view/user/location_view/widgets/filter_sheet.dart';
import 'package:calebshirthum/view/user/location_view/widgets/gym_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/seacr)with_filter_widgets.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import '../home_view/model/profile_model.dart' hide Location;
import 'controller/location_service.dart';
import 'gym_details_view.dart';

class MapScreenView extends StatefulWidget {
  const MapScreenView({super.key});

  @override
  State<MapScreenView> createState() => _MapScreenViewState();
}

class _MapScreenViewState extends State<MapScreenView> {
  final AllMapGymController _allMapGymController =
      Get.put(AllMapGymController());

  AppleMapController? mapController;
  double distance = 2;
  List<String> selectedCategories = [];
  String searchTerm = "";
  String? selectedGymId;
  double _zoomLevel = 12.0;

  LatLng? _currentLocation;
  Set<Annotation> markers = {};
  Set<Circle> circles = {};

  final LatLng _fallbackCenter = const LatLng(38.5816, -121.4944);

  @override
  void initState() {
    super.initState();
    _init();
  }

  /// INIT
  Future<void> _init() async {
    print("🔵 INIT STARTED — Calling API + location");
    await _fetchGyms();
    await _getCurrentLocation();
  }

  /// FETCH GYMS FROM API
  Future<void> _fetchGyms() async {
    try {
      print("🟡 Fetching gyms from API...");
      print(
          "➡ Distance: $distance | Categories: ${selectedCategories.join(',')} | Search: $searchTerm");

      await _allMapGymController.getAllMapGym(
        distance: distance,
        searchTerm: searchTerm,
        disciplines: selectedCategories.join(","),
      );

      final data = _allMapGymController.profile.value.data ?? [];
      print("🟢 API Response → Total gyms: ${data.length}");

      await _createMarkersFromAPI();
      _moveCameraToGyms(searchTerm: searchTerm);
    } catch (e, st) {
      print("❌ _fetchGyms error: $e");
      print(st);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to load gyms. Try again.")),
        );
      }
    }
  }

  /// GET USER LOCATION
  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location permission required.")),
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _currentLocation = LatLng(position.latitude, position.longitude);

      _updateCircleForDistance(_currentLocation!);

      markers.add(
        Annotation(
          annotationId: AnnotationId('userLocation'),
          position: _currentLocation!,
          icon: BitmapDescriptor.defaultAnnotation,
          infoWindow: InfoWindow(title: 'You are here'),
        ),
      );

      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _currentLocation!, zoom: _zoomLevel),
        ),
      );

      setState(() {});
    } catch (e) {
      print("❌ Location error: $e");
    }
  }

  Future<void> _createMarkersFromAPI() async {
    final gyms = _allMapGymController.profile.value.data ?? [];

    final customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(80, 80)),
      "assets/images/small.png",
    );

    Set<Annotation> tempMarkers = {};

    for (var gym in gyms) {
      if (gym.location?.coordinates.length == 2) {
        double lon = gym.location!.coordinates[0];
        double lat = gym.location!.coordinates[1];

        tempMarkers.add(
          Annotation(
            annotationId: AnnotationId(gym.id ?? ""),
            position: LatLng(lat, lon),
            icon: customIcon,
            infoWindow: InfoWindow(title: gym.name ?? "Gym"),
            onTap: () => _onMarkerTapped(gym.id ?? ""),
          ),
        );
      }
    }

    setState(() {
      markers.addAll(tempMarkers);
    });
  }

  void _onMarkerTapped(String gymId) {
    setState(() {
      selectedGymId = gymId;
    });
  }

  void _zoomIn() {
    if (_zoomLevel < 20) {
      setState(() {
        _zoomLevel++;
      });
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: _currentLocation ?? _fallbackCenter, zoom: _zoomLevel),
      ));
    }
  }

  void _zoomOut() {
    if (_zoomLevel > 5) {
      setState(() {
        _zoomLevel--;
      });
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: _currentLocation ?? _fallbackCenter, zoom: _zoomLevel),
      ));
    }
  }

  Future<void> _moveCameraToGyms({String? searchTerm}) async {
    final gyms = _allMapGymController.profile.value.data ?? [];
    LatLng? targetPosition;

    if (searchTerm != null && searchTerm.isNotEmpty) {
      final match = gyms.firstWhereOrNull(
        (g) =>
            g.name?.toLowerCase().contains(searchTerm.toLowerCase()) == true ||
            g.city?.toLowerCase().contains(searchTerm.toLowerCase()) == true,
      );

      if (match != null && match.location?.coordinates.length == 2) {
        targetPosition = LatLng(
            match.location!.coordinates[1], match.location!.coordinates[0]);
      } else {
        targetPosition = await LocationService.getLatLngFromAddress(searchTerm);
      }
    }

    // fallback to average of gyms or default center
    targetPosition ??= gyms.isNotEmpty
        ? LatLng(
            gyms
                    .where((g) => g.location?.coordinates.length == 2)
                    .map((g) => g.location!.coordinates[1])
                    .reduce((a, b) => a + b) /
                gyms.length,
            gyms
                    .where((g) => g.location?.coordinates.length == 2)
                    .map((g) => g.location!.coordinates[0])
                    .reduce((a, b) => a + b) /
                gyms.length)
        : _fallbackCenter;

    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: 8),
      ),
    );

    circles = {
      LocationService.createDistanceCircle(
          center: targetPosition, distanceInMiles: distance)
    };
    setState(() {});
  }

  /// UPDATE DISTANCE CIRCLE
  void _updateCircleForDistance(LatLng center) {
    circles = {
      Circle(
        circleId: CircleId('radius'),
        center: center,
        radius: distance * 1609.34, // miles to meters
        fillColor: Colors.green.withOpacity(0.2),
        strokeColor: Colors.green.withOpacity(0.4),
        strokeWidth: 3,
      )
    };
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final selectedGym = _allMapGymController.profile.value.data
        ?.firstWhereOrNull((g) => g.id == selectedGymId);

    return Scaffold(
      body: Stack(
        children: [
          AppleMap(
            initialCameraPosition: CameraPosition(
                target: _currentLocation ?? _fallbackCenter, zoom: _zoomLevel),
            annotations: markers,
            circles: circles,
            onMapCreated: (controller) {
              mapController = controller;
              _getCurrentLocation();
            },
            myLocationEnabled: true,
          ),

          /// Search Bar
          Positioned(
            top: 50.h,
            right: 16.w,
            left: 16.w,
            child: SearchBarWithFilter(
              backgroundColor: Colors.white,
              onSearchChanged: (text) async {
                searchTerm = text;

                _moveCameraToGyms(searchTerm: searchTerm);
              },
              onFilterTap: () => _openFilterSheet(context),
              hintText: 'Search location here...',
            ),
          ),

          /// Bottom Preview Card
          if (selectedGym != null)
            Positioned(
              bottom: 20.h,
              left: 16.w,
              right: 16.w,
              child: GestureDetector(
                onTap: () => Get.to(() => GymDetailsScreen(
                      gymId: selectedGym.id.toString(),
                    )),
                child: GymPreviewCard(
                  gymName: selectedGym.name ?? "No Name",
                  location: selectedGym.city ?? "No Location",
                  image: selectedGym.images.isNotEmpty
                      ? selectedGym.images.first.url ?? AppImages.gym1
                      : AppImages.gym1,
                  categories: selectedGym.disciplines,
                  showDelete: false,
                  showEdit: false,
                ),
              ),
            ),

          /// Zoom Buttons
          Positioned(
            bottom: 10.h,
            right: 16.w,
            child: Column(
              children: [
                _zoomBtn(Icons.add, _zoomIn),
                Gap(10.h),
                _zoomBtn(Icons.remove, _zoomOut),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _zoomBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
      builder: (context) {
        return FilterSheet(
          selectedCategories: selectedCategories,
          distance: distance,
          onApply: (List<String> categories, double newDistance) async {
            selectedCategories = categories;
            distance = newDistance;

            if (_currentLocation != null)
              _updateCircleForDistance(_currentLocation!);

            // Fetch gyms with new filters
            await _fetchGyms();
          },
        );
      },
    );
  }
}
