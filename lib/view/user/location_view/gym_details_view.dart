import 'package:calebshirthum/common%20widget/comon_conatainer/custom_conatiner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';

class GymDetailsScreen extends StatelessWidget {
  const GymDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
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
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainTextColors,
                  ),
                  Gap(5.h),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Color(0xFF4B4B4B), size: 16),
                      Gap(5.w),
                      CustomText(
                        text: "6157 Rd, California, USA",
                        fontSize: 12.sp,
                        color: Color(0xFF4B4B4B),
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
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w400,
                    text:
                        "GymNation Stars gives a full view of the gym’s offerings, schedule, and amenities. At the top, users see the gym name, logo, star rating, and location linked to an interactive map. A brief overview highlights services, atmosphere, and training types, with a photo gallery for a visual tour.",
                    fontSize: 12.sp,
                    color: Color(0xFF686868),
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
                  CustomContainer(
                    color:Color(0xFFF8F9FA),
                    borderColor: Color(0xFF989898),

                    height: 125.h,
                    child: Column(
                      children: [
                        _buildInfoRow(AppImages.call, "(580) 559-7890","Phone"),
                        Divider(),
                        _buildInfoRow(AppImages.teligram, "info@gymnation.com","Email"),
                        Divider(),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.earth2,
                                  height: 18.h,
                                  width: 18.w,
                                ),
                                SizedBox(width: 10.w),
                                CustomText(
                                  text: "Social",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: AppColors.mainTextColors,
                                ),
                              ],
                            ),
                          Row(children: [
                            Image.asset(
                              AppImages.https,
                              height: 18.h,
                              width: 18.w,
                            ), Gap(5.w),
                            Image.asset(
                              AppImages.fb,
                              height: 18.h,
                              width: 18.w,
                            ),Gap(5.w),   Image.asset(
                              AppImages.insta,
                              height: 18.h,
                              width: 18.w,
                            ),

                          ],)

                          ],
                        ),

                      ],
                    ),
                  ),

                  Gap(20.h),

                  // Schedule
                  CustomText(
                    text: "Schedule",
                    fontSize: 16.sp,
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
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: CustomText(
        text: text,
        fontSize: 12.sp,
        color: Color(0xFF686868),
      ),
    );
  }

  Widget _buildInfoRow(String iconPath,String text1, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child:
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                iconPath,
                height: 18.h,
                width: 18.w,
              ),
              SizedBox(width: 10.w),
              CustomText(
                text: text,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AppColors.mainTextColors,
              ),
            ],
          ),
          CustomText(
            text: text1,
            fontWeight: FontWeight.w600,

            fontSize: 14.sp,
            color: const Color(0xFF989898),
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
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.red),
                  Gap(5.w),
                  CustomText(
                    text: "$time",
                    fontSize: 10.sp,
                    color: Color(0xFF686868),
                  ),
                ],
              ),
              Gap(10.w),
              CustomText(
                text: "$days",
                fontSize: 10.sp,
                color: Color(0xFF686868),
              ),

            ],
          ),
          CustomText(
            text: "Open Mat",
            fontSize: 16.sp,
            color: AppColors.mainTextColors,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
