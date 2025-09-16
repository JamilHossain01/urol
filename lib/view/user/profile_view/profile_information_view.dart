import 'package:calebshirthum/common%20widget/custom_button_widget.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_text_filed.dart';

class ProfileInformationScreen extends StatelessWidget {
  const ProfileInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: CustomAppBar(
        title: "Profile Information",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Belt Rank",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: AppColors.backRoudnColors,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color:Color(0xFFB9B9B9))
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: "Purple",
                  items: ["White", "Blue", "Purple", "Brown", "Black"]
                      .map((rank) => DropdownMenuItem(
                    value: rank,
                    child:
                    Text(rank, style: TextStyle(fontSize: 13.sp)),
                  ))
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
            ),

            SizedBox(height: 14.h),
            CustomText(
              text: "Add Home Gym",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              hintText: "Enter your home gym",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 14.h),
            CustomText(
              text: "Add Height",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              hintText: "Enter your height",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 14.h),
            CustomText(
              text: "Add Weight",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              hintText: "Enter your weight",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 14.h),
            CustomText(
              text: "Disciplines",
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                _chip("Jiu Jitsu"),
                _chip("Wrestling"),
                _chip("Judo"),
                _chip("MMA"),
                _chip("Boxing"),
                _chip("Muay Thai"),
                _chip("Kickboxing"),
              ],
            ),
            SizedBox(height: 14.h),
            CustomText(
              text: "Favorite Quote",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              hintText: "Enter your favorite inspirational quote",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 24.h),
    CustomButtonWidget(btnText: 'Save', onTap: (){}, iconWant: false,btnColor: AppColors.mainColor,)
          ],
        ),
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE9E9E9),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: CustomText(
        text: text,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Color(0xFF686868),
      ),
    );
  }
}
