import 'package:calebshirthum/common widget/custom_button_widget.dart';
import 'package:calebshirthum/view/user/location_view/widgets/gym_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';
import 'gym_details_view.dart';

class MapScreenView extends StatefulWidget {
  const MapScreenView({super.key});

  @override
  State<MapScreenView> createState() => _MapScreenViewState();
}

class _MapScreenViewState extends State<MapScreenView> {
  GoogleMapController? mapController;
  double distance = 2;
  String selectedCategory = "Open Mat";
  final List<Map<String, String>> gymList = List.generate(
    7,
        (index) => {
      'gymName': 'GymNation Stars',
      'location': '6157 Rd, California, USA',
      'image': AppImages.gym1, // Use your own image paths here
      'categories': 'Open Mat, BJJ, MMA', // Categories
    },
  );

  final LatLng _center = const LatLng(38.5816, -121.4944); // Sacramento

  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _createMarkers();
  }

  // Create custom markers
  Future<void> _createMarkers() async {
    // Load custom marker image asynchronously
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(24, 24)),
      AppImages.mapLogo,  // Custom marker image
    );

    // Now create the markers
    setState(() {
      markers.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(38.5826, -121.4944),
          infoWindow: InfoWindow(title: "GymNation Stars"),
          icon: customIcon,
        ),
      );
      markers.add(
        Marker(
          markerId: MarkerId("2"),
          position: LatLng(38.5800, -121.4920),
          infoWindow: InfoWindow(title: "BJJ Academy"),
          icon: customIcon,
        ),
      );
      markers.add(
        Marker(
          markerId: MarkerId("3"),
          position: LatLng(38.5836, -121.4954),
          infoWindow: InfoWindow(title: "MMA Fitness Gym"),
          icon: customIcon,
        ),
      );
      markers.add(
        Marker(
          markerId: MarkerId("4"),
          position: LatLng(38.5772, -121.4936),
          infoWindow: InfoWindow(title: "Victory BJJ Academy"),
          icon: customIcon,
        ),
      );
      markers.add(
        Marker(
          markerId: MarkerId("5"),
          position: LatLng(38.5862, -121.4912),
          infoWindow: InfoWindow(title: "Fight Club Gym"),
          icon: customIcon,
        ),
      );
      markers.add(
        Marker(
          markerId: MarkerId("6"),
          position: LatLng(38.5796, -121.4908),
          infoWindow: InfoWindow(title: "The Arena Combat Academy"),
          icon: customIcon,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            onMapCreated: (controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 14.0,
            ),
            markers: markers,
          ),

          // Filter Button
          Positioned(
            top: 50.h,
            right: 16.w,
            child: InkWell(
              onTap: () => _openFilterSheet(context),
              child: Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Image.asset(
                    AppImages.filter,
                    height: 20.h,
                    width: 20.w,
                  )),
            ),
          ),

          // Gym Preview Bottom Card
          Positioned(
              bottom: 20.h,
              left: 16.w,
              right: 16.w,
              child: SizedBox(
                height: 250.h, // Adjust this height as per your UI requirement
                child: ListView.builder(
                  itemCount: gymList.length,
                  itemBuilder: (context, index) {
                    final gym = gymList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => GymDetailsScreen());
                        },
                        child: GymPreviewCard(
                          gymName: gym['gymName']!,
                          location: gym['location']!,
                          image: gym['image']!,
                          categories: gym['categories']!.split(', '),
                        ),
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }

  // Filter Bottom Sheet
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
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close),
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
                        color: Color(0xFF686868),
                      ),
                    ],
                  ),
                  Gap(15.h),

                  // Category Chips
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
                          fontSize: 12.sp, // same size for all chips
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

                  // Distance Slider
                  CustomText(
                    text: "Location Distance",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainTextColors,
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
                          onChanged: (val) {
                            setModalState(() {
                              distance = val;
                            });
                          },
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

  Widget _buildChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: CustomText(
        text: text,
        fontSize: 10.sp,
        color: Colors.black87,
      ),
    );
  }
}
