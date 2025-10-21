import 'package:calebshirthum/view/user/location_view/gym_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';

import 'package:gap/gap.dart';

import '../../location_view/location_screen_view.dart';

class MatCardData {
  final String name;
  final String distance;
  final String days;
  final String time;
  final String image;

  MatCardData({
    required this.name,
    required this.distance,
    required this.days,
    required this.time,
    required this.image,
  });
}

class NearbyMatsSection extends StatelessWidget {
  final List<MatCardData> mats;

  const NearbyMatsSection({super.key, required this.mats});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              color: AppColors.mainTextColors,
              fontWeight: FontWeight.w600,
              fontSize: 14.h,
              text: "Nearby Open Mats",
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => MapScreenView());
              },
              child: CustomText(
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600,
                fontSize: 10.h,
                text: "View All on Map",
              ),
            ),
          ],
        ),
        Gap(10.h),
        ...mats.map(
          (mat) => GestureDetector(
              onTap: () {
                Get.to(() => GymDetailsScreen());
              },
              child: _buildNearbyMatCard(
                mat.name,
                mat.distance,
                mat.days,
                mat.time,
                mat.image,
              )),
        ),
      ],
    );
  }

  Widget _buildNearbyMatCard(
    String name,
    String distance,
    String days,
    String time,
    String image,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                image,
                height: 70.h,
                width: 90.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        color: AppColors.mainTextColors,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.h,
                        text: name,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: CustomText(
                            color: const Color(0xFF686868),
                            fontSize: 10.h,
                            text: distance,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(5.h),
                  // Row(
                  //   children: [
                  //     const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                  //     Gap(4.w),
                  //     CustomText(
                  //       color: const Color(0xFF686868),
                  //       fontSize: 12.h,
                  //       text: days,
                  //     ),
                  //   ],
                  // ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: CustomText(
                        color: const Color(0xFF686868),
                        fontSize: 12.h,
                        text: days,
                      ),
                    ),
                  ),
                  Gap(5.h),

                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 12, color: Colors.grey),
                      Gap(4.w),
                      CustomText(
                        color: const Color(0xFF686868),
                        fontSize: 12.h,
                        text: time,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
