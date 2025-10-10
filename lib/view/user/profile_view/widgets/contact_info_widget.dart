import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_text_filed.dart';
import '../../../../uitilies/app_colors.dart';



class ContactInfoWidget extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController websiteController;
  final TextEditingController facebookController;
  final TextEditingController instagramController;

  const ContactInfoWidget({
    super.key,
    required this.phoneController,
    required this.emailController,
    required this.websiteController,
    required this.facebookController,
    required this.instagramController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Contact Information",
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.mainTextColors,
        ),
        SizedBox(height: 12.h),
        CustomText(
          text: "Phone Number",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        Gap(4.h),

        CustomTextField(
          controller: phoneController,
          hintText: "Enter your phone number",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
          validator: (value) {
            if (value!.isEmpty) return "Phone number is required";
            if (!RegExp(r'^\+\d{10,}$').hasMatch(value)) {
              return "Enter a valid phone number";
            }
            return null;
          },
        ),
        SizedBox(height: 12.h),
        CustomText(
          text: "Email",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        Gap(4.h),

        CustomTextField(
          controller: emailController,
          hintText: "Enter your email address",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
          validator: (value) {
            if (value!.isEmpty) return "Email is required";
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return "Enter a valid email";
            }
            return null;
          },
        ),
        SizedBox(height: 12.h),
        CustomText(
          text: "Website",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        Gap(4.h),

        CustomTextField(
          controller: websiteController,
          hintText: "Enter your website link",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
        ),
        SizedBox(height: 12.h),
        CustomText(
          text: "Facebook",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        Gap(4.h),

        CustomTextField(
          controller: facebookController,
          hintText: "Enter your Facebook link",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
        ),
        SizedBox(height: 12.h),
        CustomText(
          text: "Instagram",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        Gap(4.h),

        CustomTextField(
          controller: instagramController,
          hintText: "Enter your Instagram link",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}