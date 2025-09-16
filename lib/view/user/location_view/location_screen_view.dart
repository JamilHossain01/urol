import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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

  final LatLng _center = const LatLng(38.5816, -121.4944); // Sacramento

  Set<Marker> markers = {
    const Marker(
      markerId: MarkerId("1"),
      position: LatLng(38.5826, -121.4944),
      infoWindow: InfoWindow(title: "GymNation Stars"),
    ),
    const Marker(
      markerId: MarkerId("2"),
      position: LatLng(38.5800, -121.4920),
      infoWindow: InfoWindow(title: "BJJ Academy"),
    ),
  };

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
                  color: Colors.red.shade700,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: const Icon(Icons.filter_alt, color: Colors.white),
              ),
            ),
          ),

          // Gym Preview Bottom Card
          Positioned(
            bottom: 20.h,
            left: 16.w,
            right: 16.w,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GymDetailsScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.asset(
                        AppImages.gym1,
                        height: 120.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Gap(8.h),
                    CustomText(
                      text: "GymNation Stars",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainTextColors,
                    ),
                    CustomText(
                      text: "6157 Rd, California, USA",
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                    Gap(5.h),
                    Wrap(
                      spacing: 6.w,
                      children: [
                        _buildChip("Open Mat"),
                        _buildChip("BJJ"),
                        _buildChip("MMA"),
                        _buildChip("Boxing"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.close),
                      CustomText(
                        text: "Filter",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainTextColors,
                      ),
                      CustomText(
                        text: "See All",
                        fontSize: 12.sp,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                  Gap(15.h),

                  // Category Chips
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: "Category",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainTextColors,
                    ),
                  ),
                  Gap(8.h),
                  Wrap(
                    spacing: 8.w,
                    children: ["Open Mat", "Jiu Jitsu", "Judo", "MMA", "Wrestling"]
                        .map((cat) => ChoiceChip(
                      label: Text(cat),
                      selected: selectedCategory == cat,
                      onSelected: (val) {
                        setModalState(() {
                          selectedCategory = cat;
                        });
                      },
                      selectedColor: Colors.red.shade700,
                      labelStyle: TextStyle(
                        color: selectedCategory == cat
                            ? Colors.white
                            : Colors.black,
                      ),
                    ))
                        .toList(),
                  ),
                  Gap(15.h),

                  // Distance Slider
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: "Location Distance",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainTextColors,
                    ),
                  ),
                  Slider(
                    value: distance,
                    min: 1,
                    max: 50,
                    divisions: 50,
                    activeColor: Colors.red.shade700,
                    label: "${distance.toInt()}m",
                    onChanged: (val) {
                      setModalState(() {
                        distance = val;
                      });
                    },
                  ),
                  CustomText(
                    text: "${distance.toInt()}m",
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                  Gap(20.h),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: CustomText(
                        text: "Apply Filter",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
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

