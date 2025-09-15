import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';

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

class GymDetailsScreen extends StatelessWidget {
  const GymDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gym Cover Image
            Stack(
              children: [
                Image.asset(
                  AppImages.gym2,
                  height: 220.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40.h,
                  left: 16.w,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gym Name
                  CustomText(
                    text: "GymNation Stars",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainTextColors,
                  ),
                  Gap(5.h),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.grey, size: 16),
                      Gap(5.w),
                      CustomText(
                        text: "6157 Rd, California, USA",
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Gap(10.h),

                  // Tags
                  Wrap(
                    spacing: 8.w,
                    children: [
                      _buildChip("Open Mat"),
                      _buildChip("NO-GI"),
                      _buildChip("Brazilian Jiu-Jitsu"),
                    ],
                  ),
                  Gap(15.h),

                  // Description
                  CustomText(
                    text:
                    "GymNation Stars gives a full view of the gym’s offerings, schedule, and amenities. At the top, users see the gym name, logo, star rating, and location linked to an interactive map. A brief overview highlights services, atmosphere, and training types, with a photo gallery for a visual tour.",
                    fontSize: 12.sp,
                    color: Colors.black87,
                  ),
                  Gap(20.h),

                  // Info Section
                  CustomText(
                    text: "Information Details",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainTextColors,
                  ),
                  Gap(10.h),
                  _buildInfoRow(Icons.phone, "(580) 559-7890"),
                  _buildInfoRow(Icons.email, "info@gymnation.com"),
                  _buildInfoRow(Icons.share, "Social Links"),
                  Gap(20.h),

                  // Schedule
                  CustomText(
                    text: "Schedule",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainTextColors,
                  ),
                  Gap(10.h),
                  _buildSchedule("9:00 - 11:00 PM", "Sun - Tue"),
                  _buildSchedule("4:00 - 6:00 PM", "Wed, Thu"),
                  _buildSchedule("9:00 - 11:00 PM", "Sun, Mon"),
                  _buildSchedule("4:00 - 6:00 PM", "Tue, Wed"),
                ],
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          Gap(10.w),
          CustomText(
            text: text,
            fontSize: 12.sp,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }

  Widget _buildSchedule(String time, String days) {
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time, size: 16, color: Colors.red),
          Gap(10.w),
          Expanded(
            child: CustomText(
              text: "$time  |  $days",
              fontSize: 12.sp,
              color: AppColors.mainTextColors,
            ),
          ),
          CustomText(
            text: "Open Mat",
            fontSize: 12.sp,
            color: Colors.red,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
