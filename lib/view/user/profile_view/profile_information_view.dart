import 'package:calebshirthum/common%20widget/custom_button_widget.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_text_filed.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() => _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  String? selectedBelt = "Select One";
  String? selectedFeet = "5";
  String? selectedInches = "11";
  List<String> selectedDisciplines = ["Jiu Jitsu", "Wrestling", "Judo", "MMA", "Boxing"];
  final List<String> beltRanks = ["Select One", "White", "Blue", "Purple", "Brown", "Black"];
  final List<String> feetOptions = ["4", "5", "6", "7"];
  final List<String> inchesOptions = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"];
  final List<String> disciplines = ["Jiu Jitsu", "Wrestling", "Judo", "MMA", "Boxing", "Muay Thai", "Kickboxing"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: const CustomAppBar(
        title: "Profile Information",
        showLeadingIcon: true,
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
            _buildDropdownField(
              selectedBelt,
              beltRanks,
                  (String? value) => setState(() => selectedBelt = value),
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
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Feet",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textFieldNameColor,
                      ),
                      SizedBox(height: 6.h),
                      _buildDropdownField(
                        selectedFeet,
                        feetOptions,
                            (String? value) => setState(() => selectedFeet = value),
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
                        text: "Inches",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textFieldNameColor,
                      ),
                      SizedBox(height: 6.h),
                      _buildDropdownField(
                        selectedInches,
                        inchesOptions,
                            (String? value) => setState(() => selectedInches = value),
                      ),
                    ],
                  ),
                ),
              ],
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
              children: disciplines
                  .map(
                    (text) => _buildChip(
                  text,
                  selectedDisciplines.contains(text),
                      () => setState(() {
                    if (selectedDisciplines.contains(text)) {
                      selectedDisciplines.remove(text);
                    } else {
                      selectedDisciplines.add(text);
                    }
                  }),
                ),
              )
                  .toList(),
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
            CustomButtonWidget(
              btnText: 'Save',
              onTap: () {
                Get.back();
              },
              iconWant: false,
              btnColor: AppColors.mainColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      String? value,
      List<String> items,
      Function(String?) onChanged,
      ) {
    return Container(
      height: 46.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.backRoudnColors,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFB9B9B9)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items
              .map(
                (String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(fontSize: 13.sp),
              ),
            ),
          )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildChip(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : const Color(0xFFE9E9E9),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: CustomText(
          text: text,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : const Color(0xFF686868),
        ),
      ),
    );
  }
}