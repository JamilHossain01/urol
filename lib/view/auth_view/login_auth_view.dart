// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:calebshirthum/view/auth_view/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;

import '../../../uitilies/app_colors.dart';
import '../../common widget/custom text/custom_text_widget.dart';
import '../../common widget/custom_app_bar_widget.dart';
import '../../common widget/custom_button_widget.dart';
import '../../common widget/custom_text_filed.dart';
import '../user/dashboard_view/enable_location_view.dart';
import 'forget_password_view.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    //Phone Number/Email
                    CustomText(
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start,
                      text: "Sign in to your",
                      fontSize: 34.sp,
                      color: Color(0xFF1E1E1E),
                    ),
                    CustomText(
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start,
                      text: "account",
                      fontSize: 32.sp,
                      color: Color(0xFF1E1E1E),
                    ),
                    CustomText(
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.start,
                      fontSize: 12.sp,
                      color: Color(0xFF8A8A8A),
                      text: "Enter your email address and password to log in ",
                    ),
                    SizedBox(height: 30),

                    CustomText(
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start,
                      text: "Email",
                      color: AppColors.textFieldNameColor,
                      fontSize: 12.sp,
                    ),
                    CustomTextField(
                      fillColor: Color(0xFFFFFFFF),
                      hintText: "Enter your email address",
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
                      // fillColor: Color(0xFFE4E4E4),
                      hintText: "Enter your password",
                      showObscure: true,
                    ),
                    SizedBox(height: 10),

                    //Remember Me
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                checkboxTheme: CheckboxThemeData(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    side:
                                        BorderSide(color: AppColors.mainColor),
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                              child: Checkbox(
                                value: false,
                                onChanged: (_) {},
                                side: BorderSide(color: AppColors.mainColor),
                                activeColor: AppColors.mainColor,
                              ),
                            ),
                            SizedBox(width: 4),
                            CustomText(
                              text: "Keep me logged in",
                              fontSize: 16,
                              color: Color(0xFF686868),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ForgetPasswordView());
                          },
                          child: CustomText(
                            color: AppColors.mainColor,
                            text: "Forgot Password?",
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),

                    //Sign In Button
                    SizedBox(
                      height: 55,
                      width: double.infinity,
                      child: CustomButtonWidget(
                        btnColor: AppColors.mainColor,
                        onTap: () {
                          Get.to(() => EnableLocationView());
                        },
                        iconWant: false,
                        btnText: 'Log In',
                      ),
                    ),
                    SizedBox(height: 20),

                    //Or Continue With
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
                                image: AssetImage(AppImages.appleIcon),
                                width: 30,
                              ),
                            )),
                      ],
                    ),
                    SizedBox(height: 20),

                    //Don't have an account Sign Up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Don’t have an account?",
                          color: AppColors.pTextColors,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => SignUpView());
                          },
                          child: CustomText(
                            text: "Sign Up",
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
