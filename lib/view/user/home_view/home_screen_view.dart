import 'package:calebshirthum/common%20widget/current_location_service.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/constant.dart';
import 'package:calebshirthum/view/user/home_view/controller/open_mats_controller.dart';
import 'package:calebshirthum/view/user/home_view/widgets/greeting_section_widgets.dart';
import 'package:calebshirthum/view/user/home_view/widgets/nearby_mats_section.dart';
import 'package:calebshirthum/view/user/home_view/widgets/shimmer/shimmer_card_of_map.dart';
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
import '../location_view/location_screen_view.dart';
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

  final OpenMatsController _openMatsController = Get.put(OpenMatsController());

  final CurrentLocationService _locationService =
      Get.put(CurrentLocationService());

  @override
  void initState() {
    super.initState();
    profileController.getProfileController();
    _getCurrentLocationAndUpdateMats();
  }

  Future<void> _getCurrentLocationAndUpdateMats() async {
    bool granted = await _locationService.requestPermission();
    if (!granted) return;

    var pos = await _locationService.getCurrentLocation();
    if (pos == null) return;

    await _locationService.saveLatLong(pos.latitude, pos.longitude);

    DateTime now = DateTime.now().toUtc();
    String day = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ][now.weekday - 1];

    String hour = now.hour.toString();
    String minute = now.minute.toString().padLeft(2, '0');

    print("Lat: ${pos.latitude}, Long: ${pos.longitude}");
    print("Today: $day, Time (UTC): $hour:$minute");

    _openMatsController.getOpenMatsController(
      lat: pos.latitude.toString(),
      long: pos.longitude.toString(),
      hour: hour,
      dayName: day,
      minute: minute,
    );
  }

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
                  Obx(() {
                    if (_openMatsController.isLoading.value == true) {
                      return ShimmerCardWidgetOfMap();
                    } else if (_openMatsController.openMats.value.data ==
                            null ||
                        _openMatsController.openMats.value.data!.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Center(
                          child: CustomText(
                            text: "No nearby mats available",
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    } else {
                      return NearbyMatsSection(
                        mats: _openMatsController.openMats.value.data!.map((e) {
                          return MatCardData(
                            name: e.name ?? "N/A",
                            distance: e.distance?.toStringAsFixed(1) ?? "0 km",
                            days: e.matSchedules.isNotEmpty
                                ? e.matSchedules.map((s) => s.day).join(", ")
                                : "N/A",
                            time: e.matSchedules.isNotEmpty
                                ? "${e.matSchedules.first.fromView} - ${e.matSchedules.first.toView}"
                                : "N/A",
                            image: e.images.isNotEmpty
                                ? e.images.first.url ?? ""
                                : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
                          );
                        }).toList(),
                      );
                    }
                  }),
                  Gap(10.h),
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
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
