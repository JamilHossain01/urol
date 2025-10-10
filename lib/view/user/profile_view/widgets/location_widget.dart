import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_text_filed.dart';
import '../../../../uitilies/app_colors.dart';



class LocationWidget extends StatelessWidget {
  final TextEditingController streetAddressController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController zipCodeController;

  const LocationWidget({
    super.key,
    required this.streetAddressController,
    required this.cityController,
    required this.stateController,
    required this.zipCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Location",
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.mainTextColors,
        ),
        SizedBox(height: 12.h),
        CustomText(
          text: "Address",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        Gap(4.h),

        CustomTextField(
          controller: streetAddressController,
          hintText: "Street address",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
          validator: (value) => value!.isEmpty ? "Address is required" : null,
        ),
        SizedBox(height: 12.h),
        Row(
          children: [

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "State",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textFieldNameColor,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    decoration: BoxDecoration(
                      color: AppColors.backRoudnColors,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: Color(0xFFB9B9B9)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: stateController.text.isNotEmpty ? stateController.text : null,
                        hint: Text("Select One", style: TextStyle(fontSize: 13.sp)),
                        items: ['California', 'Texas', 'New York', 'Florida']
                            .map((state) => DropdownMenuItem(
                          value: state,
                          child: Text(state, style: TextStyle(fontSize: 13.sp)),
                        ))
                            .toList(),
                        onChanged: (value) {
                          stateController.text = value ?? '';
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "City",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textFieldNameColor,
                  ),
                  CustomTextField(
                    controller: cityController,
                    hintText: "Enter City",
                    showObscure: false,
                    fillColor: AppColors.backRoudnColors,
                    hintTextColor: AppColors.hintTextColors,
                    validator: (value) => value!.isEmpty ? "City is required" : null,
                  ),
                ],
              ),
            ),

          ],
        ),
        SizedBox(height: 12.h),
        CustomText(
          text: "Zip Code",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        Gap(4.h),

        CustomTextField(
          controller: zipCodeController,
          hintText: "Enter zip code",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
          validator: (value) => value!.isEmpty ? "Zip code is required" : null,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}