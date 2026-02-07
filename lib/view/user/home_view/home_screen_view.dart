import 'package:calebshirthum/common%20widget/current_location_service.dart';
import 'package:calebshirthum/common%20widget/custom_elipse_text.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/constant.dart';
import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:calebshirthum/view/user/home_view/controller/open_mats_controller.dart';
import 'package:calebshirthum/view/user/home_view/widgets/greeting_section_widgets.dart';
import 'package:calebshirthum/view/user/home_view/widgets/nearby_mats_section.dart';
import 'package:calebshirthum/view/user/home_view/widgets/shimmer/event_shimmer_portion.dart';
import 'package:calebshirthum/view/user/home_view/widgets/shimmer/shimmer_card_of_map.dart';
import 'package:calebshirthum/view/user/home_view/widgets/shimmer/user_info_shimmer.dart';
import 'package:calebshirthum/view/user/home_view/widgets/user_info_widgets.dart';
import 'package:calebshirthum/view/user/location_view/gym_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_date_format.dart';
import '../../../common widget/not_found_widget.dart';
import '../../../uitilies/app_images.dart';
import '../../../uitilies/custom_loader.dart';
import '../dashboard_view/bottom_navigation_view.dart';
import '../event_view/controller/get_all_event_result_controller.dart';
import '../event_view/recent_event_all_view.dart';
import '../location_view/location_screen_view.dart';
import '../profile_view/add_compition_view.dart';
import '../profile_view/widgets/event_card.dart';
import 'all_open_mats_view.dart';
import 'controller/my_profile_controller.dart';
import 'controller/unread_notification_controller.dart';

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
  final UnreadNotificationController _unreadNotificationController =
      Get.put(UnreadNotificationController());

  final GetAllEventResultController _getAllEventResultController =
      Get.put(GetAllEventResultController());

  late String today;

  @override
  void initState() {
    super.initState();

    today = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ][DateTime.now().weekday - 1];

    _getAllEventResultController.getAllEventResult();
    _getCurrentLocationAndUpdateMats();
    _unreadNotificationController.getUnReadController();
  }

  Future<void> _getCurrentLocationAndUpdateMats() async {
    bool granted = await _locationService.requestPermission();
    if (!granted) return;

    var pos = await _locationService.getCurrentLocation();
    if (pos == null) return;

    await _locationService.saveLatLong(pos.latitude, pos.longitude);

    DateTime now = DateTime.now();

    String day = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ][now.weekday - 1];

    int hour24 = now.hour;
    int hour12 = hour24 % 12;
    if (hour12 == 0) hour12 = 12;

    String hour = hour12.toString();
    String minute = now.minute.toString().padLeft(2, '0');
    String amPm = hour24 >= 12 ? "PM" : "AM";

    print("Today: $day, Time (Local): $hour:$minute $amPm");

    // CustomToast.showToast(
    //   "Today: $day, Time (Local): $hour:$minute $amPm",
    // );

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
    Widget getMedalIcon(String? result) {
      switch (result) {
        case "Gold":
          return Image.asset(
            "assets/images/goldOne.png",
            width: 26,
            height: 26,
          );
        case "Silver":
          return Image.asset(
            "assets/images/silverTwo.png",
            width: 26,
            height: 26,
          );
        case "Bronze":
          return Image.asset(
            "assets/images/bronzeThree.png",
            width: 26,
            height: 26,
          );

        case "DNP":
          return Image.asset(
            "assets/images/dnp.png",
            width: 26,
            height: 26,
          );

        default:
          return Image.asset(
            "assets/images/dnp.png",
            width: 26,
            height: 26,
          );
      }
    }

    String cmToFeetInch(dynamic cm) {
      // Convert cm → total inches
      dynamic totalInches = cm / 2.54;

      dynamic feet = totalInches ~/ 12;

      // Remaining inches
      dynamic inches = totalInches % 12;

      return "$feet' ${inches.toStringAsFixed(0)}\"";
    }

    Color getMedalColor(String? result) {
      switch (result) {
        case "Gold":
          return Colors.amber;
        case "Silver":
          return Colors.grey;
        case "Bronze":
          return Colors.brown;
        case "DNP":
          return Colors.brown;

        default:
          return Colors.grey;
      }
    }

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
                      future: Future.delayed(Duration(microseconds: 6)),
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
                            name: customEllipsisText(fullName, wordLimit: 3),
                            gymName: profileController
                                    .profile.value.data?.homeGym
                                    ?.toString() ??
                                "No home gym added yet",
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
                            weight: (() {
                              final weightStr = profileController
                                      .profile.value.data?.weight
                                      ?.toString() ??
                                  "";
                              return weightStr
                                  .replaceAll(
                                      RegExp(r'kg', caseSensitive: false), '')
                                  .trim();
                            })(),
                            height: profileController
                                        .profile.value.data?.height?.amount !=
                                    null
                                ? cmToFeetInch(profileController
                                    .profile.value.data?.height?.amount)
                                : "n/a",
                            skills: profileController
                                .profile.value.data!.disciplines,
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
                          Get.to(() => AllOpenMatsView());
                        },
                        child: CustomText(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10.h,
                          text: "View All",
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
                          child: NotFoundWidget(
                            imagePath: "assets/images/not_found.png",
                            message:
                                "Sorry, no open mats currently happening \nnear you!",
                          ),
                        ),
                      );
                    } else {
                      return NearbyMatsSection(
                        mats: _openMatsController.openMats.value.data!.map((e) {
                          final bool isToday = e.day == today;

                          return MatCardData(
                            name: e.name.toString(),
                            distance: e.distance != null
                                ? e.distance!.toStringAsFixed(1)
                                : "0.0",
                            days: isToday ? today : "N/A",
                            time: isToday &&
                                    e.fromView != null &&
                                    e.toView != null
                                ? "${e.fromView} - ${e.toView}"
                                : "N/A",
                            image: e.images.isNotEmpty
                                ? e.images.first.url ??
                                    "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541"
                                : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
                            onTap: () {
                              Get.to(() => GymDetailsScreen(
                                    gymId: e.id.toString(),
                                  ));
                            },
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AddCompetitionResultScreen());
                    },
                    child: CustomText(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.h,
                      text: "Add Competition Result",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => RecentEventAllView());
                    },
                    child: CustomText(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.h,
                      text: "View All",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Obx(() {
              final events =
                  _getAllEventResultController.profile.value.data ?? [];

              // 1️⃣ Loading state
              if (_getAllEventResultController.isLoading.value) {
                return EventCardShimmer();
              }

              // 2️⃣ No data state
              if (events.isEmpty) {
                return Center(
                  child: NotFoundWidget(
                    imagePath: "assets/images/not_found.png",
                    message: "No recent event results yet!",
                  ),
                );
              }

              // 3️⃣ Take latest 3 events (assuming latest are last)
              final latestThree = events.length > 3
                  ? events.sublist(events.length - 3)
                  : events;

              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: latestThree.length,
                itemBuilder: (context, index) {
                  final competition = latestThree[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: EventCard(
                      showAllResult: false,
                      medalColor: getMedalColor(competition.result),
                      medalIcon: getMedalIcon(competition.result),
                      showCompetition: false,
                      title: competition.eventName ?? "",
                      date: CustomDateFormatter.formatDate(
                        competition.eventDate?.toIso8601String() ?? "",
                      ),
                      division: competition.division ?? "",
                      location:
                          "${competition.city ?? ""}${competition.state != null ? ", ${competition.state}" : ""}",
                      medalText: competition.result ?? "",
                    ),
                  );
                },
              );
            }),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
