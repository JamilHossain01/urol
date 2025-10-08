import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_text_filed.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  Set<String> selectedDisciplines = {};

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Bar
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back, size: 18),
                    ),
                  ),
                  SizedBox(width: 20.w),
                  CustomText(
                    text: "Edit Profile",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Profile Picture
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 55.r,
                    backgroundImage:
                    const NetworkImage("https://via.placeholder.com/150"),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child:
                      const Icon(Icons.add, size: 18, color: Colors.white),
                    ),
                  )
                ],
              ),

              SizedBox(height: 25.h),

              // Name
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Name",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mainTextColors,
                ),
              ),
              SizedBox(height: 6.h),
              CustomTextField(
                hintTextColor: Color(0xFF6B6B6B),
                fillColor: Color(0xFFF5F5F5),
                borderColor: Color(0xFFF5F5F5),
                hintText: "Caleb Shirtum",
                showObscure: false,
              ),

              SizedBox(height: 16.h),

              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Name",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mainTextColors,
                ),
              ),
              SizedBox(height: 6.h),
              CustomTextField(
                hintTextColor: Color(0xFF6B6B6B),

                fillColor: Color(0xFFF5F5F5),
                borderColor: Color(0xFFF5F5F5),
                hintText: "Caleb Shirtum",
                showObscure: false,
              ),

              SizedBox(height: 16.h),

// Belt Rank (Dropdown)
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Belt Rank",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mainTextColors,
                ),
              ),
              SizedBox(height: 6.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8.r),
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

              SizedBox(height: 16.h),

// Email
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Email",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mainTextColors,
                ),
              ),
              SizedBox(height: 6.h),
              const CustomTextField(
                hintTextColor: Color(0xFF6B6B6B),

                fillColor: Color(0xFFF5F5F5),
                borderColor: Color(0xFFF5F5F5),
                hintText: "calebshirtum@gmail.com",
                showObscure: false,
              ),

              SizedBox(height: 16.h),

// Home Gym
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Home Gym",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mainTextColors,
                ),
              ),
              SizedBox(height: 6.h),
              const CustomTextField(
                hintTextColor: Color(0xFF6B6B6B),

                fillColor: Color(0xFFF5F5F5),
                borderColor: Color(0xFFF5F5F5),
                hintText: "The Arena Combat Academy",
                showObscure: false,
              ),

              SizedBox(height: 16.h),

// Height
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Height",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mainTextColors,
                ),
              ),
              SizedBox(height: 6.h),
              const CustomTextField(
                hintTextColor: Color(0xFF6B6B6B),

                fillColor: Color(0xFFF5F5F5),
                borderColor: Color(0xFFF5F5F5),
                hintText: "170 lb",
                showObscure: false,
              ),

              SizedBox(height: 16.h),

// Weight
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Weight",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mainTextColors,
                ),
              ),
              SizedBox(height: 6.h),
              const CustomTextField(
                hintTextColor: Color(0xFF6B6B6B),

                fillColor: Color(0xFFF5F5F5),
                borderColor: Color(0xFFF5F5F5),
                hintText: "5'10\"",
                showObscure: false,
              ),

              SizedBox(height: 16.h),

              // Disciplines (Chips)
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: "Disciplines",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mainTextColors,
                ),
              ),
              SizedBox(height: 6.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  _disciplineChip("Jiu Jitsu"),
                  _disciplineChip("Wrestling"),
                  _disciplineChip("Judo"),
                  _disciplineChip("MMA"),
                  _disciplineChip("Boxing"),
                  _disciplineChip("Muay Thai"),
                  _disciplineChip("Kickboxing"),
                ],
              ),

              SizedBox(height: 16.h),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () {},
                  child: CustomText(
                    text: "Save",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Discipline Chip
  Widget _disciplineChip(String label) {
    bool isSelected = selectedDisciplines.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedDisciplines.remove(label); // Unselect if already selected
          } else {
            selectedDisciplines.add(label); // Select if not already selected
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
