// ignore_for_file: prefer_const_constructors

import 'package:calebshirthum/view/auth_view/signUpOtp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../uitilies/app_colors.dart';
import '../../common widget/custom text/custom_text_widget.dart';
import '../../common widget/custom_app_bar_widget.dart';
import '../../common widget/custom_button_widget.dart';
import '../../common widget/custom_text_filed.dart';
import '../../uitilies/app_images.dart';
import 'login_auth_view.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Create Account"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(15.h),
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Sign up",
                fontSize: 32.sp,
                color: Color(0xFF1E1E1E),
              ),
              Gap(5.h),
              CustomText(
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.start,
                fontSize: 12.sp,
                color: Color(0xFF8A8A8A),
                text: "Create an account to continue",
              ),
              SizedBox(height: 20),

              //Full Name
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "First Name",
                color: AppColors.textFieldNameColor,
                fontSize: 12.sp,
              ),
              CustomTextField(
                hintText: "Enter first name",
                showObscure: false,
              ),
              SizedBox(height: 10),

              //Location
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Last Name",
                color: AppColors.textFieldNameColor,
                fontSize: 12.sp,
              ),
              CustomTextField(
                hintText: "Enter last name",
                showObscure: false,
              ),
              SizedBox(height: 10),

              //Email
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Email",
                color: AppColors.textFieldNameColor,
                fontSize: 12.sp,
              ),
              CustomTextField(
                hintText: "Enter your email address",
                showObscure: false,
              ),

              SizedBox(height: 10),

              //Phone Number

              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Phone Number",
                color: AppColors.textFieldNameColor,
                fontSize: 12.sp,
              ),
              CustomTextField(
                hintText: "Enter your phone number",
                showObscure: false,
              ),
              SizedBox(height: 10),
              //Password
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Password",
                color: AppColors.textFieldNameColor,
                fontSize: 12.sp,
              ),
              CustomTextField(
                hintText: "Enter your password",
                showObscure: true,
              ),
              SizedBox(height: 10),

              //Confirm Password
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Confirm Password",
                color: AppColors.textFieldNameColor,
                fontSize: 12.sp,
              ),
              CustomTextField(
                hintText: "Confirm your password",
                showObscure: true,
              ),
              SizedBox(height: 40),

              //Sign Up
              SizedBox(
                height: 55,
                width: double.infinity,
                child: CustomButtonWidget(
                  btnColor: AppColors.mainColor,
                  onTap: () {
                    Get.to(() => SignUpOTPVerifyView());
                  },
                  iconWant: false,
                  btnText: 'Sign Up',
                ),
              ),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Already have an account?",
                    color: AppColors.textFieldNameColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SignInView());
                    },
                    child: CustomText(
                      text: "Login",
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                    ),
                  )
                ],
              ),

              //Already have an account

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
