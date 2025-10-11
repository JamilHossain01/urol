import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/constant.dart';
import 'package:calebshirthum/view/user/home_view/widgets/event_results_section.dart';
import 'package:calebshirthum/view/user/home_view/widgets/greeting_section_widgets.dart';
import 'package:calebshirthum/view/user/home_view/widgets/nearby_mats_section.dart';
import 'package:calebshirthum/view/user/home_view/widgets/notification_widgets.dart';
import 'package:calebshirthum/view/user/home_view/widgets/user_info_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/app_images.dart';
import '../profile_view/add_compition_view.dart';
import '../profile_view/widgets/event_card.dart';


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
        child: Column(
          children: [
            Padding(
              padding: AppPadding.bodyPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(50.h),
                  GreetingSection(),
                  Gap(10.h),
                  UserInfoSection(
                    name: "Caleb Shirtum",
                    belt: "Purple Belt",
                    gymName: "The Arena Combat Academy",
                    quote: "Discipline is the bridge between goals and accomplishments.",
                  ),
                  Gap(10.h),
                  NearbyMatsSection(
                    mats: [
                      MatCardData(
                        name: "The Fight Club",
                        distance: "0.5 km",
                        days: "Sun, Tue",
                        time: "4:00 - 6:00 PM",
                        image: AppImages.gym1,
                      ),
                      MatCardData(
                        name: "Powerhouse Gym",
                        distance: "1 km",
                        days: "Sun - Tue",
                        time: "4:00 - 6:00 PM",
                        image: AppImages.gym2,
                      ),
                      MatCardData(
                        name: "Victory BJJ",
                        distance: "2 km",
                        days: "Wed, Fri",
                        time: "9:00 - 11:00 PM",
                        image: AppImages.gym3,
                      ),
                    ],
                  ),
                  Gap(10.h),

                  // EventResultsSection(
                  //   events: [
                  //     EventResultData(
                  //       event: "IBJJF World Championships 2024",
                  //       division: "NoGi Absolute",
                  //       location: "Buffalo, New York",
                  //       result: "GOLD",
                  //     ),
                  //   ],
                  // ),


                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        child: Image.asset(
                          AppImages.cup,
                          height: 14.h,
                          width: 14.w,
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      CustomText(
                        text: "Recent Event Results",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),

            EventCard(
              showCompetition: false,
              title: "IBJJF World Championships 2024",
              date: "March 15, 2025",
              division: "NoGi Absolute",
              location: "Buffalo, New York",
              medalText: "GOLD"

            ),
            SizedBox(height: 10.h),


          ],
        ),
      ),
    );
  }
  Widget _eventInfo(String title, String value, String iconPath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              iconPath,
              height: 14.h,
              width: 14.w,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 6.w),
            CustomText(
              text: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey.shade600,
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Color(0xFFE9E9E9),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: CustomText(
            text: value,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF686868),
          ),
        ),
      ],
    );
  }

}
