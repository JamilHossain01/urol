import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/constant.dart';
import 'package:calebshirthum/view/user/home_view/widgets/notification_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../common widget/comon_conatainer/custom_conatiner.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_images.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F9FA),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppPadding.bodyPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(50.h),

              // Greeting Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        color: const Color(0xFF686868),
                        fontSize: 10.h,
                        text: "Hello 👋🏻",
                      ),
                      CustomText(
                        color: AppColors.mainTextColors,
                        fontSize: 12.h,
                        fontWeight: FontWeight.w500,
                        text: "Good Morning,",
                      ),
                    ],
                  ),
                  NotificationBell(notificationCount: 5),
                ],
              ),
              Gap(10.h),

              // User Info Section
              CustomContainer(
                height: 150,
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundImage: AssetImage(AppImages.person),
                        ),
                        Gap(10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              color: AppColors.mainTextColors,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.h,
                              text: "Caleb Shirtum",
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.r),
                                color:
                                    const Color(0xFF8243EE).withOpacity(0.10),
                              ),
                              child: CustomText(
                                color: const Color(0xFF8243EE),
                                fontSize: 10.h,
                                fontWeight: FontWeight.w600,
                                text: "Purple Belt",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        Image.asset(AppImages.mapIcon,height: 20.h,width: 20.w,),
                        Gap(10.w),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              color: Color(0xFF8C8C8C),
                              fontWeight: FontWeight.w600,
                              fontSize: 10.h,
                              text: "Home Gym",
                            ), CustomText(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.h,
                              text: "The Arena Combat Academy",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(15.h),

              // Home Gym Section
              // CustomContainer(
              //   color: Colors.black87,
              //   child:
              //   Row(
              //     children: [
              //       const Icon(Icons.location_on, color: Colors.white),
              //       Gap(10.w),
              //       Expanded(
              //         child: CustomText(
              //           color: Colors.white,
              //           fontWeight: FontWeight.w600,
              //           fontSize: 14.h,
              //           text: "The Arena Combat Academy",
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Gap(10.h),

              // Nearby Open Mats Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    color: AppColors.mainTextColors,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.h,
                    text: "Nearby Open Mats",
                  ),
                  CustomText(
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.h,
                    text: "View All on Map",
                  ),
                ],
              ),
              Gap(10.h),
              _buildNearbyMatCard(
                "The Fight Club",
                "0.5 km",
                "Sun, Tue",
                "4:00 - 6:00 PM",
                AppImages.gym1,
              ),
              _buildNearbyMatCard(
                "Powerhouse Gym",
                "1 km",
                "Sun - Tue",
                "4:00 - 6:00 PM",
                AppImages.gym2,
              ),
              _buildNearbyMatCard(
                "Victory BJJ",
                "2 km",
                "Wed, Fri",
                "9:00 - 11:00 PM",
                AppImages.gym3,
              ),
              // Gap(20.h),

              // Recent Event Results Section
              Row(
                children: [
                  Image.asset(AppImages.cup,height: 20.w,width: 20.w,),
                  Gap(5.w),
                  CustomText(
                    color: AppColors.mainTextColors,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.h,
                    text: "Recent Event Results",
                  ),
                ],
              ),
              Gap(10.h),
              _buildEventResult(
                "IBJJF World Championships 2024",
                "NoGi Absolute",
                "Buffalo, New York",
                "GOLD",
              ),
              Gap(10.h),

            ],
          ),
        ),
      ),
    );
  }

  // Nearby Mats Card
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
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
            12.r
              ),
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
                      CustomText(
                        color: const Color(0xFF686868),
                        fontSize: 10.h,
                        text: distance,
                      ),
                    ],
                  ),
                  Gap(5.h),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 12, color: Colors.grey),
                      Gap(4.w),
                      CustomText(
                        color: const Color(0xFF686868),
                        fontSize: 12.h,
                        text: days,
                      ),
                    ],
                  ),
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

  // Event Results Card
  Widget _buildEventResult(
    String event,
    String division,
    String location,
    String result,
  ) {
    return Container(
      padding: EdgeInsets.all(12.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            color: AppColors.mainTextColors,
            fontWeight: FontWeight.w600,
            fontSize: 14.h,
            text: event,
          ),
          Gap(5.h),
          Row(
            children: [
              const Icon(Icons.category, size: 14, color: Colors.grey),
              Gap(5.w),
              CustomText(
                color: const Color(0xFF686868),
                fontSize: 12.h,
                text: division,
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.location_on, size: 14, color: Colors.grey),
              Gap(5.w),
              CustomText(
                color: const Color(0xFF686868),
                fontSize: 12.h,
                text: location,
              ),
            ],
          ),
          Gap(10.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Center(
              child: CustomText(
                color: Colors.white,
                fontSize: 14.h,
                fontWeight: FontWeight.w600,
                text: result,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
