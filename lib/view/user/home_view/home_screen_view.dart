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
              // Pass data as parameters to the widgets
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
              EventResultsSection(
                events: [
                  EventResultData(
                    event: "IBJJF World Championships 2024",
                    division: "NoGi Absolute",
                    location: "Buffalo, New York",
                    result: "GOLD",
                  ),
                ],
              ),
              Gap(10.h),

            ],
          ),
        ),
      ),
    );
  }
}
