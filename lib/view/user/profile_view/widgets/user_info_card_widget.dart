import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_button_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/app_images.dart';
import '../edite_profeil_view.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          /// 🏠 Home Gym Section
          Row(
            children: [
              Container(
                height: 38.h,
                width: 38.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF989898),
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
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 10.h),

          /// 📏 Height and Weight Row
          Row(
            children: [
              _infoTile(AppImages.scale, "Height", "5'10\""),
              Gap(10.w),
              _infoTile(AppImages.kg, "Weight", "170 lb"),
            ],
          ),

          SizedBox(height: 10.h),

          /// 🎯 Skills Section
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
            color: const Color(0xFF000000).withOpacity(0.10),
          ),
          SizedBox(height: 4.h),

          /// 🧠 Favorite Quote
          CustomText(
            text: "Favorite Quote",
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4B4B4B),
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

          /// ✏️ Edit Button
          CustomButtonWidget(
            btnText: 'Edit',
            onTap: () {
              Get.to(() => const EditProfileView());
            },
            iconWant: false,
            btnColor: Colors.white,
            btnTextColor: AppColors.mainColor,
            borderColor: AppColors.mainColor,
          ),
        ],
      ),
    );
  }

  /// 🔹 Info Tile for Height / Weight
  Widget _infoTile(String iconPath, String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, height: 20.h, width: 20.w),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: label,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
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
      ),
    );
  }

  /// 🔹 Skill Chip Widget
  Widget _skillChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: CustomText(
        text: text,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.mainColor,
      ),
    );
  }
}
