import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/constant.dart';
import 'package:calebshirthum/view/user/home_view/widgets/greeting_section_widgets.dart';
import 'package:calebshirthum/view/user/home_view/widgets/nearby_mats_section.dart';
import 'package:calebshirthum/view/user/home_view/widgets/shimmer/user_info_shimmer.dart';
import 'package:calebshirthum/view/user/home_view/widgets/user_info_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_date_format.dart';
import '../../../uitilies/app_images.dart';
import '../../../uitilies/custom_loader.dart';
import '../profile_view/widgets/event_card.dart';
import 'controller/my_profile_controller.dart';

class HomeScreenView extends StatefulWidget {
  HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final GetProfileController profileController =
      Get.put(GetProfileController());

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

                  Obx(() {
                    bool isLoading = profileController.isLoading.value;
                    return FutureBuilder(
                      future: Future.delayed(Duration(seconds: 1)),
                      builder: (context, snapshot) {
                        if (isLoading ||
                            snapshot.connectionState != ConnectionState.done) {
                          return UserInfoSectionShimmer();
                        } else {
                          String firstName =
                              profileController.profile.value.data?.firstName ??
                                  "";
                          String lastName =
                              profileController.profile.value.data?.lastName ??
                                  "";
                          String fullName = "$firstName $lastName".trim();

                          return UserInfoSection(
                            name: fullName,
                            gymName: profileController
                                    .profile.value.data?.homeGym
                                    ?.toString() ??
                                "N/A",
                            quote: profileController
                                    .profile.value.data?.favouriteQuote
                                    ?.toString() ??
                                "No quote added yet",
                            image: profileController.profile.value.data?.image
                                    ?.toString() ??
                                "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
                            beltRank: profileController
                                    .profile.value.data?.beltRank
                                    .toString() ??
                                "",
                          );
                        }
                      },
                    );
                  }),

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
            if (profileController.profile.value.data?.competition != null)
              Obx(() {
                return profileController.isLoading.value == true
                    ? CustomLoader()
                    : EventCard(
                        showCompetition: false,
                        title: profileController
                                .profile.value.data?.competition?.eventName ??
                            "",
                        date: CustomDateFormatter.formatDate(profileController
                                .profile.value.data?.competition?.eventDate
                                .toString() ??
                            ""),
                        division: profileController
                                .profile.value.data?.competition?.division ??
                            "",
                        location: profileController
                                .profile.value.data?.competition?.city ??
                            "",
                        medalText: profileController
                                .profile.value.data?.competition?.result ??
                            "",
                      );
              }),
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
