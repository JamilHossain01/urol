// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_app_bar_widget.dart';
import '../../../../common widget/custom_button_widget.dart';
import '../../../../common widget/custom_text_filed.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../auth_view/login_auth_view.dart';


class ChangedNewPasswordView extends StatelessWidget {
  const ChangedNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: 'Change Password'),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SafeArea(
                child: SingleChildScrollView( // Added SingleChildScrollView here
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),

                      CustomText(
                        text: "Old Password",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textFieldNameColor,
                      ),
                      SizedBox(height: 5.h),

                      CustomTextField(
                        hintText: "Old Password",
                        showObscure: true,

                        fillColor: AppColors.backRoudnColors,
                        hintTextColor: AppColors.hintTextColors,
                      ),
                      SizedBox(height: 5.h),

                      CustomText(
                        text: "New Password",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textFieldNameColor,
                      ),
                      SizedBox(height: 5.h),
                      CustomTextField(
                        hintText: "New Password",
                        showObscure: true,
                        fillColor: AppColors.backRoudnColors,
                        hintTextColor: AppColors.hintTextColors,
                      ),
                      SizedBox(height: 5.h),

                      CustomText(
                        text: "Confirm Password",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textFieldNameColor,


                      ),
                      SizedBox(height: 5.h),

                      CustomTextField(
                        hintText: "Confirm Password",
                        showObscure: true,
                        fillColor: AppColors.backRoudnColors,
                        hintTextColor: AppColors.hintTextColors,
                      ),

                      SizedBox(height: 30),
                      SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: CustomButtonWidget(
                          btnColor: AppColors.mainColor,
                          onTap: () {
                            Get.to(() => SignInView());
                          },
                          iconWant: false,
                          btnText: 'Save',
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _strengthText(int strength) {
    switch (strength) {
      case 1:
        return 'Very Weak';
      case 2:
        return 'Weak';
      case 3:
        return 'Medium';
      case 4:
        return 'Strong';
      case 5:
        return 'Very Strong';
      default:
        return '';
    }
  }
}