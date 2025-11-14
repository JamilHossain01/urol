// ignore_for_file: prefer_const_constructors

import 'package:calebshirthum/common widget/custom_button_widget.dart';
import 'package:calebshirthum/view/user/location_view/controller/all_map_gym_controller.dart';
import 'package:calebshirthum/view/user/location_view/widgets/gym_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/seacr)with_filter_widgets.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
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
        disciplines: selectedCategories.join(","), // comma separated
      );

      final data = _allMapGymController.profile.value.data ?? [];
      print("🟢 API Response → Total gyms: ${data.length}");

      for (var g in data) {
        print(
            "🏋 Gym: ${g.name} | ID: ${g.id} | coords: ${g.location?.coordinates}");
      }

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

  /// CREATE MARKERS FROM API DATA
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

  /// MOVE CAMERA TO ALL GYMS OR SEARCH MATCH
  void _moveCameraToGyms({String? searchTerm}) {
    final gyms = _allMapGymController.profile.value.data ?? [];
    if (gyms.isEmpty) return;

    LatLng? targetPosition;

    // Check if searchTerm matches any gym name or city
    if (searchTerm != null && searchTerm.isNotEmpty) {
      final match = gyms.firstWhereOrNull(
        (g) =>
            g.name?.toLowerCase().contains(searchTerm.toLowerCase()) == true ||
            g.city?.toLowerCase().contains(searchTerm.toLowerCase()) == true,
      );
      if (match != null && match.location?.coordinates.length == 2) {
        targetPosition = LatLng(
          match.location!.coordinates[1],
          match.location!.coordinates[0],
        );
      }
    }

    // If no search match, use average of all gyms
    if (targetPosition == null) {
      double sumLat = 0;
      double sumLon = 0;
      int count = 0;

      for (var g in gyms) {
        if (g.location?.coordinates.length == 2) {
          sumLon += g.location!.coordinates[0];
          sumLat += g.location!.coordinates[1];
          count++;
        }
      }

      if (count == 0) return;
      targetPosition = LatLng(sumLat / count, sumLon / count);
    }

    // Move camera to the target position
    mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: targetPosition, zoom: 15),
      ),
    );

    _updateCircleForDistance(targetPosition);
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
              onSearchChanged: (text) {
                searchTerm = text;
              },
              onFilterTap: () => _openFilterSheet(context),
            ),
          ),

          /// Bottom Preview Card
          if (selectedGym != null)
            Positioned(
              bottom: 20.h,
              left: 16.w,
              right: 16.w,
              child: GestureDetector(
                onTap: () => Get.to(() => GymDetailsScreen()),
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

  /// FILTER SHEET
  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSheet) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.pop(context)),
                      CustomText(
                          text: "Filter",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600),
                      CustomText(
                          text: "See All",
                          fontSize: 12.sp,
                          color: Color(0xFF686868)),
                    ],
                  ),
                  Gap(15.h),

                  /// Category Filter
                  CustomText(
                      text: "Category",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500),
                  Gap(8.h),
                  Wrap(
                    spacing: 8.w,
                    children:
                        ["Open Mat", "Jiu Jitsu", "Judo", "MMA", "Wrestling"]
                            .map(
                              (cat) => ChoiceChip(
                                backgroundColor: AppColors.mainColor,
                                selectedColor: AppColors.mainColor,
                                label: CustomText(
                                  text: cat,
                                  fontSize: 12.sp,
                                  color: selectedCategories.contains(cat)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                selected: selectedCategories.contains(cat),
                                onSelected: (_) {
                                  if (selectedCategories.contains(cat)) {
                                    selectedCategories.remove(cat);
                                  } else {
                                    selectedCategories.add(cat);
                                  }
                                  setStateSheet(() {});
                                },
                              ),
                            )
                            .toList(),
                  ),
                  Gap(15.h),

                  /// Distance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(text: "Location Distance", fontSize: 16.sp),
                      CustomText(text: "Miles", fontSize: 14.sp),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: distance,
                          min: 1,
                          max: 50,
                          activeColor: AppColors.mainColor,
                          onChanged: (val) =>
                              setStateSheet(() => distance = val),
                        ),
                      ),
                      CustomText(text: "${distance.toInt()}m", fontSize: 12.sp),
                    ],
                  ),

                  Gap(20.h),

                  /// APPLY FILTER
                  CustomButtonWidget(
                    btnColor: AppColors.mainColor,
                    btnTextColor: Colors.white,
                    btnText: 'Apply Filter',
                    onTap: () async {
                      Navigator.pop(context);
                      await _fetchGyms();
                    },
                    iconWant: false,
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
