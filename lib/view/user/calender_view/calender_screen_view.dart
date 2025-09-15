import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';

class EventScreenView extends StatefulWidget {
  const EventScreenView({super.key});

  @override
  State<EventScreenView> createState() => _EventScreenViewState();
}

class _EventScreenViewState extends State<EventScreenView> {
  String selectedEventType = "IBJJF";
  double distance = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(40.h),

            // Title
            CustomText(
              text: "Events",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColors,
            ),
            Gap(15.h),

            // Search + Filter Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search here...",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                  ),
                ),
                Gap(10.w),
                InkWell(
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
              ],
            ),
            Gap(20.h),

            // Example Section Header
            CustomText(
              text: "September 2025",
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.mainTextColors,
            ),
            Gap(10.h),

            // Events List
            Expanded(
              child: ListView(
                children: [
                  _buildEventCard(
                    date: "SEP\n20\n2025",
                    title:
                    "Rio Summer International Open IBJJF Jiu-Jitsu No-Gi Championship 2025",
                    org: "IBJJF",
                    location: "Arena Carioca 1, Parque Olimpico",
                    status: "Open Registration",
                    daysLeft: "2 Days",
                    price: "\$120",
                    link: "Tap to register on IBJJF website",
                    image: AppImages.gym1,
                  ),
                  _buildEventCard(
                    date: "SEP\n21\n2025",
                    title:
                    "Rio Summer Kids International Open IBJJF Jiu-Jitsu Championship 2025",
                    org: "IBJJF",
                    location: "Arena Carioca 1, Parque Olimpico",
                    status: "Open Registration",
                    daysLeft: "2 Days",
                    price: "\$120",
                    link: "Tap to register on IBJJF website",
                    image: AppImages.gym2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Event Card
  Widget _buildEventCard({
    required String date,
    required String title,
    required String org,
    required String location,
    required String status,
    required String daysLeft,
    required String price,
    required String link,
    required String image,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Event Image with Date Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  bottomLeft: Radius.circular(12.r),
                ),
                child: Image.asset(
                  image,
                  height: 120.h,
                  width: 100.w,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: CustomText(
                    text: date,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          // Event Info
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainTextColors,
                  ),
                  Gap(5.h),

                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: location,
                          fontSize: 11.sp,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          text: org,
                          fontSize: 10.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  Gap(6.h),

                  // Status Row
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          text: daysLeft,
                          fontSize: 10.sp,
                          color: Colors.green,
                        ),
                      ),
                      Gap(5.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          text: status,
                          fontSize: 10.sp,
                          color: Colors.orange,
                        ),
                      ),
                      const Spacer(),
                      CustomText(
                        text: price,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainTextColors,
                      ),
                    ],
                  ),
                  Gap(6.h),

                  // Link
                  InkWell(
                    onTap: () {},
                    child: CustomText(
                      text: link,
                      fontSize: 10.sp,
                      color: Colors.blue,
                    ),
                  ),
                ],
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

                  // Event Types
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: "Event type",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainTextColors,
                    ),
                  ),
                  Gap(8.h),
                  Wrap(
                    spacing: 8.w,
                    children: ["AGF", "IBJJF", "NAGA", "ADCC", "Local"]
                        .map((type) => ChoiceChip(
                      label: Text(type),
                      selected: selectedEventType == type,
                      onSelected: (val) {
                        setModalState(() {
                          selectedEventType = type;
                        });
                      },
                      selectedColor: Colors.red.shade700,
                      labelStyle: TextStyle(
                        color: selectedEventType == type
                            ? Colors.white
                            : Colors.black,
                      ),
                    ))
                        .toList(),
                  ),
                  Gap(15.h),

                  // City / State
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter City",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade300, width: 1),
                            ),
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 10.w),
                          ),
                        ),
                      ),
                      Gap(10.w),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: "Select One",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          items: ["NY", "CA", "TX"]
                              .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ),
                  Gap(15.h),

                  // Location Distance
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
                  Gap(10.h),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
