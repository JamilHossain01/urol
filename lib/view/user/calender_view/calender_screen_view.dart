import 'package:calebshirthum/common%20widget/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_button_widget.dart';
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
      appBar: CustomAppBar(
        title: 'Events',
        showLeadingIcon: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        color: Color(0xFFB9B9B9),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFFB9B9B9),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Gap(10.w),
                InkWell(
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
              ],
            ),
            Gap(20.h),

            // Example Section Header
            CustomText(
              text: "September 2025",
              fontSize: 18.sp,
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
        color: Color(0xFFF8F9FA),
        border: Border.all(
          color: Color(0xFF989898),
        ),
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
                  topLeft: Radius.circular(30.r),
                  bottomLeft: Radius.circular(12.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Image.asset(
                    image,
                    height: 120.h,
                    width: 70.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                left: 20.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: CustomText(
                    text: date,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Aligns multi-line text to the top
                    children: [
                      Expanded(
                        child: CustomText(
                          text: title,
                          textAlign: TextAlign.start,
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                          // Prevents overflow errors
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.mainTextColors,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFFF6C6E),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          text: org,
                          fontSize: 10.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  Gap(5.h),

                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: location,
                          fontSize: 12.sp,
                          color: Color(0xFF686868),
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
                          color: Color(0xFf22C65F),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          text: daysLeft,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Gap(5.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFBB24),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          text: status,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Gap(5.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFB9B9B9),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          text: price,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Gap(6.h),

                  // Link
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CustomText(
                          text: link,
                          fontSize: 10.sp,
                          color: Color(0xFF1D52FF),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 12,
                          color: Color(0xFF1D52FF),
                        )
                      ],
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
              child: SingleChildScrollView(
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
                
                    // Event Types
                    CustomText(
                      text: "Event type",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.mainTextColors,
                    ),
                    Gap(8.h),
                    Wrap(
                      spacing: 8.w,
                      children: ["AGF", "IBJJF", "NAGA", "ADCC", "Local"]
                          .map(
                            (type) => ChoiceChip(
                          backgroundColor: Color(0xFFF5F5F5),
                          label: CustomText(
                            text: type,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: selectedEventType == type
                                ? Colors.white
                                : Colors.black,
                          ),
                          selected: selectedEventType == type,
                          selectedColor: AppColors.mainColor,
                          onSelected: (_) {
                            setModalState(() {
                              selectedEventType = type;
                            });
                          },
                        ),
                      )
                          .toList(),
                    ),
                    Gap(15.h),
                
                    // City / State
                    Row(
                      children: [
                        // City
                        // State
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "State",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.mainTextColors,
                              ),
                              SizedBox(height: 6.h),
                              SizedBox(
                                height: 50.h,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    hintText: "Select One",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300, width: 1),
                                    ),
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10.w),
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
                        ),                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "City",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.mainTextColors,
                              ),
                              SizedBox(height: 6.h),
                              SizedBox(
                                height: 50.h,
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
                            ],
                          ),
                        ),


                      ],
                    ),
                    Gap(15.h),
                
                    // Location Distance
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
                    Gap(15.h),
                
                    // Apply Button
                    CustomButtonWidget(
                        btnColor: AppColors.mainColor,
                        btnTextColor: Colors.white,
                        btnText: 'Apply Filter',
                        onTap: () => Navigator.pop(context),
                        iconWant: false),
                    Gap(10.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
