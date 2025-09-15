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
import 'login_auth_view.dart';

class SignUpOTPVerifyView extends StatelessWidget {
  SignUpOTPVerifyView({super.key});

  String? countryCode;
  String? localNumber;

  final TextEditingController _numberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "OTP Verify"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Center(
                child: CustomText(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    text: "Enter Your Verification Code"),
              ),
              SizedBox(height: 20),

              CustomText(
                text:
                "Please enter the 6-digit code sent to your phone number.",
                color: Colors.grey,
              ),
              SizedBox(height: 30),
              OtpForm(
                controller: otpController,
              ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: AppString.notOTP,
                  ),
                  CustomText(
                    text: "Resend OTP",
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                ],
              ),

              /// Phone number field

              SizedBox(height: 40),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: CustomButtonWidget(
                  btnColor: AppColors.mainColor,
                  onTap: () {
                    Get.to(() => SignInView());
                  },
                  iconWant: false,
                  btnText: 'Submit',
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
