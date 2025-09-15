// ignore_for_file: prefer_const_constructors

import 'package:calebshirthum/view/auth_view/signUpOtp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  String? countryCode;
  String? localNumber;

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

              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Sign up",
                fontSize: 32.sp,
                color: Color(0xFF1E1E1E),
              ),  CustomText(
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.start,
                fontSize: 12.sp,
                color: Color(0xFF8A8A8A),

                text: "Create an account to continue!",
              ),
              SizedBox(height: 40),


              //Full Name
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "First Name",
              ),
              CustomTextField(
                hintText: "Enter full name",
                showObscure: false,
              ),
              SizedBox(height: 10),

              //Location
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Last Name",
              ),
              CustomTextField(
                hintText: "Enter your address",
                showObscure: false,
              ),
              SizedBox(height: 10),

              //Email
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Email",
              ),
              CustomTextField(
                hintText: "Enter your email",
                showObscure: false,
              ),

              SizedBox(height: 10),


              //Phone Number


              /// Phone number field
              // IntlPhoneField(
              //   controller: _numberController,
              //   decoration: InputDecoration(
              //     hintStyle: GoogleFonts.outfit(fontSize: 12.h),
              //     fillColor: Color(0xFFE4E4E4),
              //     filled: true,
              //     labelStyle: GoogleFonts.urbanist(fontSize: 13.h),
              //     hintText: "Phone Number".tr,
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8.sp),
              //       borderSide: BorderSide(
              //         color: Colors.transparent,
              //         width: 1.5,
              //       ),
              //     ),
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: AppColors.mainColor,
              //         width: 1.0,
              //       ),
              //       borderRadius: BorderRadius.circular(12.0),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderSide: BorderSide(
              //         color: AppColors.mainColor,
              //         width: 1.0,
              //       ),
              //       borderRadius: BorderRadius.circular(12.0),
              //     ),
              //   ),
              //   initialCountryCode: 'AE',
              //   onChanged: (phone) {
              //     // setState(() {
              //     //   countryCode = phone.countryCode;
              //     //   localNumber = phone.number;
              //     // });
              //   },
              // ),

              //Password
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "New Password",
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
              ),
              CustomTextField(
                hintText: "Enter confirm password",
                showObscure: true,
              ),
              SizedBox(height: 20),

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
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(color: Colors.grey, width: 160, height: 1.5),
                  CustomText(text: "Or"),
                  Container(color: Colors.grey, width: 160, height: 1.5),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Image(
                          image: AssetImage("assets/images/google.png"),
                          width: 30,
                        ),
                      )),
                  SizedBox(width: 20),
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Image(
                          image: AssetImage(AppImages.googleIcon),
                          width: 30,
                        ),
                      )),
                ],
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: "Already have an account?"),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SignUpView());
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
