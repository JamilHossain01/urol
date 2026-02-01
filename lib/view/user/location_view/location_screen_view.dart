// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:calebshirthum/common widget/custom_button_widget.dart';
import 'package:calebshirthum/common%20widget/custom_elipse_text.dart';
import 'package:calebshirthum/view/user/location_view/controller/all_map_gym_controller.dart';
import 'package:calebshirthum/view/user/location_view/widgets/filter_sheet.dart';
import 'package:calebshirthum/view/user/location_view/widgets/gym_preview_card.dart';
import 'package:calebshirthum/view/user/location_view/widgets/map_gym_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;

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

  AppleMapController? appleMapController;
  gmap.GoogleMapController? googleMapController;

  double distance = 2;
  List<String> selectedCategories = [];
  String searchTerm = "";
  String? selectedGymId;
  double _zoomLevel = 5.0;

  LatLng? _currentLocation;
  Set<Annotation> markers = {};
  Set<Circle> circles = {};

  Uint8List? customGoogleIconBytes;
  BitmapDescriptor? customAppleIcon;

  final LatLng _fallbackCenter = const LatLng(38.5816, -121.4944);

  bool _isGymPreviewCardVisible = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    appleMapController = null;
    googleMapController = null;
    super.dispose();
  }

  Future<void> _init() async {
    await _loadMarkerIcons();
    if (!mounted) return;

    await _fetchGyms();
    if (!mounted) return;

    await _getCurrentLocation();
  }

  Future<void> _loadMarkerIcons() async {
    customAppleIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(80, 80)),
      "assets/images/small.png",
    );

    ByteData data = await rootBundle.load("assets/images/small.png");
    customGoogleIconBytes = data.buffer.asUint8List();
  }

  Future<void> _fetchGyms() async {
    try {
      await _allMapGymController.getAllMapGym(
        distance: distance,
        searchTerm: searchTerm,
        disciplines: selectedCategories.join(","),
      );

      if (!mounted) return;
      await _createMarkersFromAPI();

      if (!mounted) return;
      _moveCameraToGyms(searchTerm: searchTerm);
    } catch (e) {
      debugPrint("Fetch gyms error: $e");
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location permission required.")),
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      _currentLocation = LatLng(position.latitude, position.longitude);

      markers.add(
        Annotation(
          annotationId: AnnotationId('userLocation'),
          position: _currentLocation!,
          icon: BitmapDescriptor.defaultAnnotation,
          infoWindow: InfoWindow(title: 'You are here'),
        ),
      );

      if (!mounted) return;
      setState(() {});

      _animateToPosition(_currentLocation!, _zoomLevel);
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  Future<void> _createMarkersFromAPI() async {
    final gyms = _allMapGymController.profile.value.data ?? [];
    Set<Annotation> temp = {};

    /// Same location counter (LatLng direct use না করে string key)
    Map<String, int> locationCounter = {};

    for (var gym in gyms) {
      if (gym.location?.coordinates != null &&
          gym.location!.coordinates.length == 2) {
        double lon = gym.location!.coordinates[0];
        double lat = gym.location!.coordinates[1];

        LatLng baseLocation = LatLng(lat, lon);

        /// Key to avoid floating precision issue
        final String key =
            "${lat.toStringAsFixed(6)},${lon.toStringAsFixed(6)}";

        locationCounter[key] = (locationCounter[key] ?? 0) + 1;
        int count = locationCounter[key]!;

        double offsetLat = 0.0;
        double offsetLon = 0.0;

        /// 🔹 Only if same location repeats
        if (count > 1) {
          /// Apple map এর জন্য খুব ছোট offset (~1 meter)
          final double angle = (count * 60) * (math.pi / 180);
          const double radius = 0.00001; // ✅ VERY SMALL OFFSET

          offsetLat = radius * math.sin(angle);
          offsetLon = radius * math.cos(angle);
        }

        LatLng adjustedLocation = LatLng(lat + offsetLat, lon + offsetLon);

        temp.add(
          Annotation(
            annotationId: AnnotationId(gym.id ?? ""),
            position: adjustedLocation,
            icon: customAppleIcon!,
            infoWindow: InfoWindow(title: gym.name ?? "Gym"),
            onTap: () => _onMarkerTapped(gym.id ?? ""),
          ),
        );
      }
    }

    if (!mounted) return;

    setState(() {
      markers.clear();
      markers.addAll(temp);
    });
  }

  void _onMarkerTapped(String gymId) {
    if (!mounted) return;
    setState(() {
      selectedGymId = gymId;
      _isGymPreviewCardVisible = true;
    });
  }

  void _animateToPosition(LatLng? pos, double zoom) {
    if (Platform.isIOS && appleMapController != null) {
      appleMapController!.animateCamera(
        CameraUpdate.newCameraPosition(
            CameraPosition(target: pos!, zoom: zoom)),
      );
    } else if (Platform.isAndroid && googleMapController != null) {
      googleMapController!.animateCamera(
        gmap.CameraUpdate.newCameraPosition(
          gmap.CameraPosition(
            target: gmap.LatLng(pos!.latitude!, pos.longitude),
            zoom: zoom,
          ),
        ),
      );
    }
  }

  Future<void> _moveCameraToGyms({String? searchTerm}) async {
    final gyms = _allMapGymController.profile.value.data ?? [];
    LatLng? target;

    if (searchTerm != null && searchTerm.isNotEmpty) {
      final match = gyms.firstWhereOrNull((g) =>
          (g.name?.toLowerCase().contains(searchTerm.toLowerCase()) == true) ||
          (g.city?.toLowerCase().contains(searchTerm.toLowerCase()) == true) ||
          (g.state?.toLowerCase().contains(searchTerm.toLowerCase()) == true) ||
          (g.zipCode?.toLowerCase().contains(searchTerm.toLowerCase()) ==
              true));

      if (match != null && match.location?.coordinates.length == 2) {
        target = LatLng(
          match.location!.coordinates[1],
          match.location!.coordinates[0],
        );
      }
    }

    // Fallback center if no match is found
    target ??= _fallbackCenter;

    _animateToPosition(target, 12);

    circles = {
      Circle(
        circleId: CircleId("radius"),
        center: target,
        radius: distance * 1700,
        fillColor: Colors.green.withOpacity(0.2),
        strokeColor: Colors.green.withOpacity(0.5),
        strokeWidth: 6,
      )
    };

    if (!mounted) return;
    setState(() {});
  }

  Set<gmap.Marker> get googleMarkers {
    return markers.map((ann) {
      bool isUser = ann.annotationId.value == 'userLocation';
      return gmap.Marker(
        markerId: gmap.MarkerId(ann.annotationId.value),
        position: gmap.LatLng(ann.position.latitude, ann.position.longitude),
        icon: isUser
            ? gmap.BitmapDescriptor.defaultMarker
            : gmap.BitmapDescriptor.fromBytes(customGoogleIconBytes!),
        infoWindow: gmap.InfoWindow(title: ann.infoWindow?.title),
        onTap: () => _onMarkerTapped(ann.annotationId.value),
      );
    }).toSet();
  }

  Set<gmap.Circle> get googleCircles {
    return circles.map((c) {
      return gmap.Circle(
        circleId: gmap.CircleId(c.circleId.value),
        center: gmap.LatLng(c.center.latitude, c.center.longitude),
        radius: c.radius,
        fillColor: c.fillColor,
        strokeColor: c.strokeColor,
        strokeWidth: c.strokeWidth,
      );
    }).toSet();
  }

  void _zoomIn() {
    if (_zoomLevel < 20) {
      _zoomLevel++;
      _animateToPosition(_currentLocation, _zoomLevel);
    }
  }

  void _zoomOut() {
    if (_zoomLevel > 5) {
      _zoomLevel--;
      _animateToPosition(_currentLocation, _zoomLevel);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedGym = _allMapGymController.profile.value.data
        ?.firstWhereOrNull((g) => g.id == selectedGymId);

    return Scaffold(
      body: Stack(
        children: [
          Platform.isIOS
              ? AppleMap(
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation ?? _fallbackCenter,
                    zoom: _zoomLevel,
                  ),
                  annotations: markers,
                  circles: circles,
                  onMapCreated: (c) {
                    appleMapController = c;
                    _getCurrentLocation();
                  },
                  myLocationEnabled: true,
                )
              : gmap.GoogleMap(
                  initialCameraPosition: gmap.CameraPosition(
                    target: gmap.LatLng(
                      (_currentLocation ?? _fallbackCenter).latitude,
                      (_currentLocation ?? _fallbackCenter).longitude,
                    ),
                    zoom: _zoomLevel,
                  ),
                  markers: googleMarkers,
                  circles: googleCircles,
                  onMapCreated: (c) {
                    googleMapController = c;
                    _getCurrentLocation();
                  },
                  myLocationEnabled: true,
                ),
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
          if (_isGymPreviewCardVisible && selectedGym != null)
            Positioned(
              bottom: 20.h,
              left: 16.w,
              right: 16.w,
              child: MapGymView(
                viewDetails: () {
                  print("here is the docs: ${selectedGym.id}");
                  Get.to(
                      () => GymDetailsScreen(gymId: selectedGym.id.toString()));
                },
                showDelete: true,
                centerGymName: true,
                imageFit: BoxFit.fitHeight,
                delete: () {
                  setState(() {
                    _isGymPreviewCardVisible = false;
                  });
                },
                gymName: selectedGym.name ?? "No Name",
                location:
                    customEllipsisText(selectedGym.street ?? '', wordLimit: 11),
                image: selectedGym.images.isNotEmpty
                    ? selectedGym.images.first.url ?? AppImages.gym1
                    : AppImages.gym1,
                categories: selectedGym.disciplines,
                showEdit: false,
                gymId: selectedGym.id?.toString() ?? '',
                phoneNumber: selectedGym.phone.toString() ?? "n/a",
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return FilterSheet(
          selectedCategories: selectedCategories,
          distance: distance,
          onApply: (List<String> categories, double newDistance) async {
            selectedCategories = categories;
            distance = newDistance;
            await _fetchGyms();
          },
        );
      },
    );
  }
}
