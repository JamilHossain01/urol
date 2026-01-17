// ignore_for_file: prefer_const_constructors

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
import '../../uitilies/custom_loader.dart';
import '../../uitilies/custom_toast.dart';
import 'controller/forget_password_controller.dart';
import 'otp_verify_filed_view.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});

  final TextEditingController emailController = TextEditingController();

  final ForgotPasswordController _forgotPasswordController =
      Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                fontWeight: FontWeight.w600,
                fontSize: 32.sp,
                text: "Forgot password?",
              ),
              SizedBox(height: 8.h),
              CustomText(
                text: "Enter your email address to reset password",
                color: Color(0xFF8A8A8A),
                fontSize: 12.sp,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 20.h),
              CustomText(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                text: "Email",
                color: AppColors.pTextColors,
              ),

              /// Phone number field

              CustomTextField(
                controller: emailController,
                hintText: "Enter your email",
                hintTextColor: Color(0xFF989898),
                showObscure: false,
              ),
              SizedBox(height: 20.h),

              Obx(() {
                return _forgotPasswordController.isLoading.value
                    ? Center(
                        child: CustomLoader(),
                      )
                    : SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: CustomButtonWidget(
                          btnColor: AppColors.mainColor,
                          onTap: () {
                            if (emailController.text.isEmpty) {
                              CustomToast.showToast("Please enter your email address",
                                  isError: true);
                            } else {
                              _forgotPasswordController.emailSubmit(
                                  email: emailController.text);
                            }
                          },
                          iconWant: false,
                          btnText: 'Send Code',
                        ),
                      );
              }),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
