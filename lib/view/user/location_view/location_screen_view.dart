import 'package:calebshirthum/common widget/custom_button_widget.dart';
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
  AppleMapController? mapController;
  double distance = 2; // Distance in miles for radius
  String selectedCategory = "Open Mat";
  String? selectedGym;
  double _zoomLevel = 14.0;

  LatLng? _currentLocation; // User current location
  Set<Annotation> markers = {};
  Set<Circle> circles = {}; // Circle to show radius

  final LatLng _center = const LatLng(38.5816, -121.4944);

  final List<Map<String, String>> gymList = [
    {
      'gymName': 'GymNation Stars',
      'location': '6157 Rd, California, USA',
      'image': AppImages.gym1,
      'categories': 'Open Mat, BJJ, MMA',
    },
    {
      'gymName': 'BJJ Academy',
      'location': '1234 Rd, California, USA',
      'image': AppImages.gym2,
      'categories': 'BJJ, MMA',
    },
    {
      'gymName': 'MMA Fitness Gym',
      'location': '7890 Rd, California, USA',
      'image': AppImages.gym3,
      'categories': 'MMA, Boxing',
    },
    {
      'gymName': 'Victory BJJ Academy',
      'location': '2345 Rd, California, USA',
      'image': AppImages.gym2,
      'categories': 'BJJ',
    },
    {
      'gymName': 'Fight Club Gym',
      'location': '6789 Rd, California, USA',
      'image': AppImages.gym2,
      'categories': 'Boxing, MMA',
    },
    {
      'gymName': 'The Arena Combat Academy',
      'location': '4321 Rd, California, USA',
      'image': AppImages.gym2,
      'categories': 'MMA, Kickboxing',
    },
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _createMarkers();
  }

  /// Fetch user current location and add circle
  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permission is required.")),
        );
        return;
      }

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      _currentLocation = LatLng(position.latitude, position.longitude);

      // Add circle for distance
      circles = {
        Circle(
          circleId: CircleId('current_location_radius'),
          center: _currentLocation!,
          radius: distance * 369.34,
          fillColor: Colors.red.withOpacity(0.2),
          strokeColor: Colors.red.withOpacity(0.5), //
          strokeWidth: 4,
        )
      };

      markers.add(
        Annotation(
          annotationId: AnnotationId('current_location_marker'),
          position: _currentLocation!,
          icon: BitmapDescriptor.defaultAnnotation,
          infoWindow: const InfoWindow(title: 'You are here'),
        ),
      );

      if (mapController != null) {
        mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _currentLocation!, zoom: _zoomLevel),
          ),
        );
      }

      setState(() {});
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  Future<void> _createMarkers() async {
    final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(100, 100)),
      "assets/images/small.png",
    );

    setState(() {
      markers = gymList.asMap().entries.map((entry) {
        final index = entry.key;
        final gym = entry.value;

        return Annotation(
          annotationId: AnnotationId(index.toString()),
          position: LatLng(38.5826 + index * 0.01, -121.4944 + index * 0.01),
          icon: customIcon,
          infoWindow: InfoWindow(title: gym['gymName']),
          onTap: () => _onMarkerTapped(gym['gymName'].toString()),
        );
      }).toSet();
    });
  }

  void _onMarkerTapped(String gymName) {
    setState(() {
      selectedGym = gymName;
    });
  }

  void _zoomIn() {
    if (_zoomLevel < 20.0) {
      setState(() {
        _zoomLevel += 1;
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: _currentLocation ?? _center, zoom: _zoomLevel),
          ),
        );
      });
    }
  }

  void _zoomOut() {
    if (_zoomLevel > 5.0) {
      setState(() {
        _zoomLevel -= 1;
        mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                target: _currentLocation ?? _center, zoom: _zoomLevel),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Find the details of the selected gym
    final selectedGymDetails = gymList.firstWhere(
      (gym) => gym['gymName'] == selectedGym,
      orElse: () => {},
    );

    return Scaffold(
      body: Stack(
        children: [
          AppleMap(
            initialCameraPosition: CameraPosition(
                target: _currentLocation ?? _center, zoom: _zoomLevel),
            annotations: markers,
            circles: circles,
            onMapCreated: (controller) {
              mapController = controller;
              _getCurrentLocation(); // Always center on current location
            },
            myLocationEnabled: true,
          ),

          /// 🔍 Search Bar + Filter
          Positioned(
            top: 50.h,
            right: 16.w,
            left: 16.w,
            child: SearchBarWithFilter(
              backgroundColor: Colors.white,
              onFilterTap: () => _openFilterSheet(context),
            ),
          ),

          /// Gym Preview Bottom List
          if (selectedGym != null) ...[
            Positioned(
              bottom: 20.h,
              left: 16.w,
              right: 16.w,
              child: GestureDetector(
                onTap: () => Get.to(() => const GymDetailsScreen()),
                child: GymPreviewCard(
                  gymName: selectedGymDetails['gymName'] ?? 'No Gym Name',
                  location: selectedGymDetails['location'] ?? 'No Location',
                  image: selectedGymDetails['image'] ?? AppImages.gym1,
                  categories:
                      (selectedGymDetails['categories'] ?? '').split(', '),
                  showDelete: true,
                  showEdit: true,
                ),
              ),
            ),
          ],

          /// Zoom In/Out Buttons
          Positioned(
            bottom: 10.h,
            right: 16.w,
            child: Column(
              children: [
                GestureDetector(
                  onTap: _zoomIn,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
                Gap(10.h),
                GestureDetector(
                  onTap: _zoomOut,
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
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
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                      CustomText(
                        text: "Filter",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainTextColors,
                      ),
                      CustomText(
                        text: "See All",
                        fontSize: 12.sp,
                        color: const Color(0xFF686868),
                      ),
                    ],
                  ),
                  Gap(15.h),
                  CustomText(
                    text: "Category",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainTextColors,
                  ),
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
                                  fontWeight: FontWeight.w500,
                                  color: selectedCategory == cat
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                selected: selectedCategory == cat,
                                onSelected: (val) {
                                  setModalState(() {
                                    selectedCategory = cat;
                                  });
                                },
                              ),
                            )
                            .toList(),
                  ),
                  Gap(15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Location Distance",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainTextColors,
                      ),
                      CustomText(
                        text: "Miles",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.pTextColors,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: distance,
                          min: 1,
                          max: 50,
                          divisions: 50,
                          activeColor: AppColors.mainColor,
                          onChanged: (val) =>
                              setModalState(() => distance = val),
                        ),
                      ),
                      CustomText(
                        text: "${distance.toInt()}m",
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Gap(20.h),
                  CustomButtonWidget(
                    btnColor: AppColors.mainColor,
                    btnTextColor: Colors.white,
                    btnText: 'Apply Filter',
                    onTap: () => Navigator.pop(context),
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
