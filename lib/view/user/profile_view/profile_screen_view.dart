import 'package:calebshirthum/common%20widget/comon_conatainer/custom_conatiner.dart';
import 'package:calebshirthum/common%20widget/custom_button_widget.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:calebshirthum/view/user/profile_view/profile_information_view.dart';
import 'package:calebshirthum/view/user/profile_view/save_gyms.dart';
import 'package:calebshirthum/view/user/profile_view/settings_view.dart';
import 'package:calebshirthum/view/user/setting/views/about_view.dart';
import 'package:calebshirthum/view/user/setting/views/privacy_policy.dart';
import 'package:calebshirthum/view/user/setting/views/termOcondition_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import 'add_compition_view.dart';
import 'edite_profeil_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),

              // Profile Image + Belt
              Column(
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 100.w,
                      height: 100.w,
                      child: OctoImage(
                        image: CachedNetworkImageProvider(
                          AppImages.person, // Profile image link
                        ),
                        // ---------- use BlurHash as placeholder ----------

                        // fallback error
                        errorBuilder: (context, error, stack) => Center(
                          child: Icon(Icons.error, color: Colors.red),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CustomText(
                      text: "Purple Belt",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CustomText(
                    text: "Caleb Shirtum",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainTextColors,
                  ),
                ],
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
                          height: 40.h,
                          width: 40.w,
                          decoration: BoxDecoration(
                            color: Color(0xFF989898),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
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
                              color: Color(0xFFE8E8E8),
                            ),
                            CustomText(
                              text: "The Arena Combat Academy",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoTile(AppImages.scale, "Height", "5'10\""),
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
                    CustomText(
                      text:
                          "“Discipline is the bridge between goals and accomplishments.”",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                    SizedBox(height: 8.h),
                    CustomButtonWidget(
                      btnText: 'Edite',
                      onTap: () {
                        Get.to(() => EditProfileView());
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

              // Recent Event Results
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Recent Event Results",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "IBJJF World Championships 2024",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _eventInfo("Division", "NoGi Absolute",
                                  AppImages.division),
                              _eventInfo("Location", "Buffalo, New York",
                                  AppImages.Location),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Center(
                            child: Column(
                              children: [
                                SizedBox(height: 8.h),
                                CustomButtonWidget(
                                  btnText: 'GOLD',
                                  onTap: () {},
                                  iconWant: false,
                                  btnColor: Color(0xFFE6E6E6),
                                  btnTextColor: AppColors.mainColor,
                                  // borderColor: AppColors.mainColor,
                                ),
                                SizedBox(height: 8.h),
                                CustomButtonWidget(
                                  btnText: 'Edite',
                                  onTap: () {},
                                  iconWant: false,
                                  btnColor: Colors.white,
                                  btnTextColor: AppColors.mainColor,
                                  borderColor: AppColors.mainColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 20.h),

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
                    _otherTile("Personal Information", AppImages.profileA, () {
                      Get.to(() => ProfileInformationScreen());
                    }),
                    _otherTile("Saved Gyms", AppImages.book_mark, () {
                      Get.to(() => SaveGymsView());
                    }),
                    _otherTile("Notifications", AppImages.bell2, () {
                      Get.to(() => ProfileInformationScreen());
                    }),
                    _otherTile("About us", AppImages.support, () {
                      Get.to(() => AboutUsView());
                    }),  _otherTile("Privacy Policy", AppImages.privacy, () {
                      Get.to(() => PrivacyPolicyScreen());
                    }),  _otherTile("Terms of service", AppImages.terms, () {
                      Get.to(() => TermsConditionsView());
                    }),
                    _otherTile("Settings", AppImages.setting, () {
                      Get.to(() => AccountSettingsScreen());
                    }),
                    _otherTile("Logout", AppImages.log_out, () {
                      Get.to(() => ProfileInformationScreen());
                    }),
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

  // ✅ Info Tile (Height, Weight)
// ✅ Info Tile (with asset image icon)
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

  // ✅ Other Tile
// ✅ Other Tile (with asset icon)
  Widget _otherTile(String text, String iconPath, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CustomContainer(
        color: const Color(0xFFE9E9E9),
        borderRadius: 8,
        height: 55.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 12.w), // padding left
                Image.asset(
                  iconPath,
                  height: 18.h,
                  width: 18.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 10.w),
                CustomText(
                  text: text,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Icon(
                Icons.chevron_right,
                size: 20.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
