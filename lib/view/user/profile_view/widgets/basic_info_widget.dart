import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_text_filed.dart';
import '../../../../uitilies/app_colors.dart';

class BasicInfoWidget extends StatelessWidget {
  final TextEditingController gymNameController;
  final TextEditingController descriptionController;

  const BasicInfoWidget({
    super.key,
    required this.gymNameController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Basic Information",
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.mainTextColors,
        ),
        SizedBox(height: 12.h),
        CustomText(
          text: "Gym Name",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        Gap(4.h),
        CustomTextField(
          controller: gymNameController,
          hintText: "Enter your gym name",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
          validator: (value) => value!.isEmpty ? "Gym name is required" : null,
        ),
        SizedBox(height: 12.h),
        CustomText(
          text: "Description",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.mainTextColors,
        ),
        Gap(4.h),
        CustomTextField(
          controller: descriptionController,
          hintText: "Enter your gym description",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
          maxLines: 3,
          validator: (value) =>
              value!.isEmpty ? "Description is required" : null,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
