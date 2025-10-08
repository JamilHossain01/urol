import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/app_images.dart';

class GymInfo extends StatelessWidget {
  final String gymName, location;
  final List<String> skills;

  const GymInfo({
    Key? key,
    required this.gymName,
    required this.location,
    required this.skills,
  }) : super(key: key);

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
                    text: gymName,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          _infoTile(AppImages.scale, "Height", "5'10\""),
          _infoTile(AppImages.kg, "Weight", "170 lb"),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: skills.map((skill) => _skillChip(skill)).toList(),
          ),
          SizedBox(height: 10.h),
          CustomText(
            text: "“Discipline is the bridge between goals and accomplishments.”",
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ],
      ),
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
}
