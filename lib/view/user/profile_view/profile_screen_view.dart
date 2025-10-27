import 'package:calebshirthum/common%20widget/comon_conatainer/custom_conatiner.dart';
import 'package:calebshirthum/common%20widget/custom_button_widget.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:calebshirthum/view/user/profile_view/add_events_view.dart';
import 'package:calebshirthum/view/user/profile_view/friend_screen_view.dart';
import 'package:calebshirthum/view/user/profile_view/my_gyms_view.dart';
import 'package:calebshirthum/view/user/profile_view/profile_information_view.dart';
import 'package:calebshirthum/view/user/profile_view/save_gyms.dart';
import 'package:calebshirthum/view/user/profile_view/settings_view.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/event_card.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/other_tile.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/profille_header_widgets.dart';
import 'package:calebshirthum/view/user/setting/views/about_view.dart';
import 'package:calebshirthum/view/user/setting/views/privacy_policy.dart';
import 'package:calebshirthum/view/user/setting/views/termOcondition_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:octo_image/octo_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../home_view/widgets/user_info_widgets.dart';
import 'Add_your_gym.dart';
import 'add_compition_view.dart';
import 'edite_gyms_details.dart';
import 'edite_profeil_view.dart';
import 'notification_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

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
              'uJitsu',
              style: GoogleFonts.libreBaskerville(
                fontSize: 18.sp,
                color: AppColors.mainColor,
              ),
            ),
            SizedBox(width: 10),
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
              ProfileHeaderWithBelt(
                imageUrl: AppImages.person,
                name: 'Caleb Shirtum',
              ),

              SizedBox(height: 20.h),

              // Home Gym Section
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 38.h,
                          width: 38.w,
                          decoration: BoxDecoration(
                            color: Color(0xFF989898),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              AppImages.location,
                              height: 18.h,
                              width: 15.w,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Home Gym",
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.pTextColors,
                            ),
                            CustomText(
                              text: "The Arena Combat Academy",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        _infoTile(AppImages.scale, "Height", "5'10\""),
                        Gap(10.w),
                        _infoTile(AppImages.kg, "Weight", "170 lb"),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 6.h,
                      children: [
                        _skillChip("Jiu Jitsu"),
                        _skillChip("Wrestling"),
                        _skillChip("Judo"),
                        _skillChip("MMA"),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Divider(
                      color: Color(0xFF000000).withOpacity(0.10),
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: "Favorite Quote",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4B4B4B),
                    ),
                    SizedBox(height: 10.h),
                    CustomText(
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      text:
                          "“Discipline is the bridge between goals and accomplishments.”",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                    SizedBox(height: 8.h),
                    CustomButtonWidget(
                      btnText: 'Edit',
                      onTap: () {
                        Get.to(() => EditProfileView());
                        // Get.to(() => EditGymDetailsScreen());
                      },
                      iconWant: false,
                      btnColor: Colors.white,
                      btnTextColor: AppColors.mainColor,
                      borderColor: AppColors.mainColor,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
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

              // Recent Event Results
              EventCard(
                title: "IBJJF World Championships 2024",
                date: "March 15, 2025",
                division: "NoGi Absolute",
                location: "Buffalo, New York",
                medalText: "GOLD",
              ),

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
                      onTap: () => Get.to(() => AddEventsView()),
                    ),
                    OtherTile(
                      text: "My Gyms",
                      iconPath: AppImages.myGym,
                      onTap: () => Get.to(() => MyGymsView()),
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
                      onTap: () => showLogoutDialog(context, onConfirm: () {
                        // Your logout logic here
                        print("User logged out");
                      }),
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

  void showLogoutDialog(BuildContext context, {VoidCallback? onConfirm}) {
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
                        onPressed: () {
                          Get.back();
                          if (onConfirm != null) onConfirm();
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

  // ✅ Event Info
// ✅ Event Info (with asset icon)
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
