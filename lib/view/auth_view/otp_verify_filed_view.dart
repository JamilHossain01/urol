// ignore_for_file: prefer_const_constructors

import 'package:calebshirthum/view/auth_view/widget/otp_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../uitilies/app_colors.dart';
import '../../common widget/custom text/custom_text_widget.dart';
import '../../common widget/custom_app_bar_widget.dart';
import '../../common widget/custom_button_widget.dart';
import '../../uitilies/app_string.dart';
import 'create_new_password_view.dart';

class OTPVerifyView extends StatelessWidget {
  OTPVerifyView({super.key});

  String? countryCode;
  String? localNumber;

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body:
      SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              CustomText(
                  fontWeight: FontWeight.w600,
                  fontSize: 32.sp,
                  text: "Verification Code"),
              SizedBox(height:4.h),

              CustomText(
                text:
                "Please enter the code we just sent to your email",
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: Color(0xFF8A8A8A),
              ),
              SizedBox(height: 30),
              Center(
                child: OtpForm(
                  controller: otpController,
                ),
              ),
              SizedBox(height: 15.h),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: AppString.notOTP,
                      fontWeight: FontWeight.w500,
                      color: AppColors.pTextColors,
                      fontSize: 12.sp,
                    ),
                    CustomText(
                      text: "Resend Code",
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: AppColors.mainColor,
                      underlined: true, // Adds underline
                      underlineColor: AppColors.mainColor,
                      underlineThickness: 3.0,// Custom underline color
                    )



                  ],
                ),
              ),

              /// Phone number field

              SizedBox(height: 40),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: CustomButtonWidget(
                  btnColor: AppColors.mainColor,
                  onTap: () {
                    Get.to(() => CreateNewPasswordView());
                  },
                  iconWant: false,
                  btnText: 'Verify',
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
