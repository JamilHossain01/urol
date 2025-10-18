import 'package:calebshirthum/common widget/custom_button_widget.dart';
import 'package:calebshirthum/view/user/location_view/widgets/gym_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
  double distance = 2;
  String selectedCategory = "Open Mat";
  String? selectedGym; // Track the selected gym
  final List<Map<String, String>> gymList = List.generate(
    7,
    (index) => {
      'gymName': 'GymNation Stars',
      'location': '6157 Rd, California, USA',
      'image': AppImages.gym1,
      'categories': 'Open Mat, BJJ, MMA',
    },
  );

  final LatLng _center = const LatLng(38.5816, -121.4944);
  Set<Annotation> markers = {};

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  Future<void> _createMarkers() async {
    final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(100, 100)),
      "assets/images/small.png",
    );

    setState(() {
      markers = {
        Annotation(
          annotationId: AnnotationId("1"),
          position: const LatLng(38.5826, -121.4944),
          icon: customIcon,
          infoWindow: const InfoWindow(title: "GymNation Stars"),
          onTap: () => _onMarkerTapped("GymNation Stars"),
        ),
        Annotation(
          annotationId: AnnotationId("2"),
          position: const LatLng(38.5800, -121.4920),
          icon: customIcon,
          infoWindow: const InfoWindow(title: "BJJ Academy"),
          onTap: () => _onMarkerTapped("BJJ Academy"),
        ),
        Annotation(
          annotationId: AnnotationId("3"),
          position: const LatLng(38.5836, -121.4954),
          icon: customIcon,
          infoWindow: const InfoWindow(title: "MMA Fitness Gym"),
          onTap: () => _onMarkerTapped("MMA Fitness Gym"),
        ),
        Annotation(
          annotationId: AnnotationId("4"),
          position: const LatLng(38.5772, -121.4936),
          icon: customIcon,
          infoWindow: const InfoWindow(title: "Victory BJJ Academy"),
          onTap: () => _onMarkerTapped("Victory BJJ Academy"),
        ),
        Annotation(
          annotationId: AnnotationId("5"),
          position: const LatLng(38.5862, -121.4912),
          icon: customIcon,
          infoWindow: const InfoWindow(title: "Fight Club Gym"),
          onTap: () => _onMarkerTapped("Fight Club Gym"),
        ),
        Annotation(
          annotationId: AnnotationId("6"),
          position: const LatLng(38.5796, -121.4908),
          icon: customIcon,
          infoWindow: const InfoWindow(title: "The Arena Combat Academy"),
          onTap: () => _onMarkerTapped("The Arena Combat Academy"),
        ),
      };
    });
  }

  // Handle marker tap and update the selected gym
  void _onMarkerTapped(String gymName) {
    setState(() {
      selectedGym = gymName; // Set the selected gym's name
    });
  }

  @override
  Widget build(BuildContext context) {
    // Find the selected gym details based on selectedGym
    final selectedGymDetails = gymList.firstWhere(
      (gym) => gym['gymName'] == selectedGym,
      orElse: () => {},
    );

    return Scaffold(
      body: Stack(
        children: [
          AppleMap(
            initialCameraPosition: CameraPosition(target: _center, zoom: 14.0),
            annotations: markers,
            onMapCreated: (controller) => mapController = controller,
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

          if (selectedGym != null) ...[
            Positioned(
              bottom: 20.h,
              left: 16.w,
              right: 16.w,
              child: GestureDetector(
                onTap: () => Get.to(() => const GymDetailsScreen()),
                child: GymPreviewCard(
                  gymName: 'GymNation Stars',
                  location: '6157 Rd, California, USA',
                  image: AppImages.gym1,
                  categories: ['Open Mat', 'BJJ', 'MMA'],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 🧾 Filter Bottom Sheet
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
                                backgroundColor: const Color(0xFFF5F5F5),
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
