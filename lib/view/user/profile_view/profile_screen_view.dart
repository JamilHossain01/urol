import 'package:calebshirthum/common%20widget/custom_date_format.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:calebshirthum/view/auth_view/login_auth_view.dart';
import 'package:calebshirthum/view/user/profile_view/add_events_view.dart';
import 'package:calebshirthum/view/user/profile_view/friend_screen_view.dart';
import 'package:calebshirthum/view/user/profile_view/my_event_screen.dart';
import 'package:calebshirthum/view/user/profile_view/my_gyms_view.dart';
import 'package:calebshirthum/view/user/profile_view/profile_information_view.dart';
import 'package:calebshirthum/view/user/profile_view/save_gyms.dart';
import 'package:calebshirthum/view/user/profile_view/settings_view.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/event_card.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/other_tile.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/profille_header_widgets.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/shimmer/profile_header_shimmer.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/shimmer/user_info_shimmer.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/user_info_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../uitilies/api/local_storage.dart';
import '../home_view/controller/my_profile_controller.dart';
import 'Add_your_gym.dart';
import 'notification_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GetProfileController _getProfileController =
      Get.put(GetProfileController());

  final RxBool _showShimmerFor2s = true.obs;

  String cmToFeetInch(dynamic cm) {
    // Convert cm → total inches
    dynamic totalInches = cm / 2.54;

    // Extract feet
    dynamic feet = totalInches ~/ 12;

    // Remaining inches
    dynamic inches = totalInches % 12;

    return "$feet' ${inches.toStringAsFixed(0)}\"";
  }

  @override
  void initState() {
    super.initState();
    _getProfileController.getProfileController();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _showShimmerFor2s.value = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Profile',
              style: GoogleFonts.libreBaskerville(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                String firstName =
                    _getProfileController.profile.value.data?.firstName ?? "";
                String lastName =
                    _getProfileController.profile.value.data?.lastName ?? "";
                String fullName = "$firstName $lastName".trim();

                return _getProfileController.isLoading.value == true
                    ? ProfileHeaderShimmer()
                    : ProfileHeaderWithBelt(
                        imageUrl: _getProfileController
                                .profile.value.data?.image
                                ?.toString() ??
                            "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png?20150327203541",
                        name: fullName,
                        beltRank: _getProfileController
                                .profile.value.data?.beltRank
                                .toString() ??
                            "",
                      );
              }),
              SizedBox(height: 10.h),
              // Home Gym Section

              Obx(() {
                if (_getProfileController.isLoading.value) {
                  return UserInfoCardShimmer();
                } else {
                  final data = _getProfileController.profile.value.data;
                  return UserInfoCard(
                    homeGym: data?.homeGym ?? "N/A",
                    height: data?.height?.amount != null
                        ? cmToFeetInch(data!.height!.amount!)
                        : "",
                    weight: (() {
                      final weightStr = data?.weight?.toString() ?? "";
                      return weightStr
                          .replaceAll(RegExp(r'kg', caseSensitive: false), '')
                          .trim();
                    })(),
                    skills: data?.disciplines ?? [],
                    favoriteQuote: data?.favouriteQuote ?? "No quote added yet",
                  );
                }
              }),

              SizedBox(height: 20.h),

              if (_getProfileController.profile.value.data?.competition != null)
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

              SizedBox(height: 12.h),
              Obx(() {
                return _getProfileController.isLoading.value == true
                    ? CustomLoader()
                    : EventCard(
                        medalColor: _getProfileController
                                    .profile.value.data?.competition?.result ==
                                "Gold"
                            ? Colors.amber
                            : _getProfileController.profile.value.data
                                        ?.competition?.result ==
                                    "Silver"
                                ? Colors.grey
                                : _getProfileController.profile.value.data
                                            ?.competition?.result ==
                                        "Bronze"
                                    ? Colors.brown
                                    : Colors.brown,
                        showCompetition: true,
                        title: _getProfileController
                                .profile.value.data?.competition?.eventName ??
                            "No competition results yet!",
                        date: CustomDateFormatter.formatDate(
                            _getProfileController
                                    .profile.value.data?.competition?.eventDate
                                    .toString() ??
                                "n/a"),
                        division: _getProfileController
                                .profile.value.data?.competition?.division ??
                            "Not division added yet",
                        location: _getProfileController
                                .profile.value.data?.competition?.city ??
                            "No location yet",
                        medalText: _getProfileController
                                .profile.value.data?.competition?.result ??
                            " No competition results yet",
                        medalIcon: _getProfileController
                                    .profile.value.data?.competition?.result ==
                                "Gold"
                            ? "assets/images/gold.png"
                            : _getProfileController.profile.value.data
                                        ?.competition?.result ==
                                    "Silver"
                                ? "assets/images/silver.png"
                                : _getProfileController.profile.value.data
                                            ?.competition?.result ==
                                        "Bronze"
                                    ? "assets/images/bronze.png"
                                    : "assets/icon/icon.png",
                      );
              }),

              // Others Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Others",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    OtherTile(
                      text: "Personal Information",
                      iconPath: AppImages.profileA,
                      onTap: () => Get.to(() => ProfileInformationScreen()),
                    ),
                    OtherTile(
                      text: "Saved Gyms",
                      iconPath: AppImages.book_mark,
                      onTap: () => Get.to(() => SaveGymsView()),
                    ),
                    OtherTile(
                      text: "Add Your Gym",
                      iconPath: AppImages.add,
                      onTap: () => Get.to(() => AddYourGymDetailsScreen()),
                    ),
                    OtherTile(
                      text: "Add Event",
                      iconPath: AppImages.calenderA,
                      onTap: () => Get.to(() => AddEventsView(
                            isEdit: false,
                          )),
                    ),
                    OtherTile(
                      text: "My Gyms",
                      iconPath: AppImages.myGym,
                      onTap: () => Get.to(() => MyGymsView()),
                    ),
                    OtherTile(
                      text: "My Events",
                      iconPath: AppImages.calenderA,
                      onTap: () => Get.to(() => MyEventScreen()),
                    ),
                    OtherTile(
                      text: "Friends",
                      iconPath: AppImages.friend,
                      onTap: () => Get.to(() => FriendsScreen()),
                    ),
                    OtherTile(
                      text: "Notifications",
                      iconPath: AppImages.bell2,
                      onTap: () => Get.to(() => NotificationsScreen()),
                    ),
                    OtherTile(
                      text: "Settings",
                      iconPath: AppImages.setting,
                      onTap: () => Get.to(() => AccountSettingsScreen()),
                    ),
                    OtherTile(
                      text: "Logout",
                      iconPath: AppImages.log_out,
                      onTap: () => showLogoutDialog(context, onConfirm: () {}),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _infoTile(String iconPath, String title, String value) {
    return Expanded(
      child: Row(
        children: [
          Image.asset(iconPath, height: 18.h, width: 18.w),
          SizedBox(width: 4.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.pTextColors,
              ),
              CustomText(
                text: value,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _skillChip(String skill) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: CustomText(
        text: skill,
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.mainColor,
      ),
    );
  }
}

void showLogoutDialog(BuildContext context, {VoidCallback? onConfirm}) {
  final StorageService _storageService = Get.put(StorageService());

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: 510,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Logout Account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Are you sure you want to logout your account? Please confirm your decision.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              const Divider(height: 1, color: Colors.black12),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: Colors.black12,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () async {
                        await _storageService.remove('accessToken');

                        Get.offAll(() => SignInView());

                        CustomToast.showToast("Logout Successfully Done!");
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _infoTile(String iconPath, String title, String value) {
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
      CustomText(
        text: value,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    ],
  );
}

// ✅ Skill Chip
Widget _skillChip(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: AppColors.mainColor,
      borderRadius: BorderRadius.circular(20.r),
    ),
    child: CustomText(
      text: text,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
  );
}
