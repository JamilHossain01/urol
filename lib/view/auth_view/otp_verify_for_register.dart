// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:calebshirthum/view/auth_view/widget/otp_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../uitilies/app_colors.dart';
import '../../common widget/custom text/custom_text_widget.dart';
import '../../common widget/custom_app_bar_widget.dart';
import '../../common widget/custom_button_widget.dart';
import '../../uitilies/app_string.dart';
import 'controller/otp_submit_controller.dart';
import 'create_new_password_view.dart';

class OTPVerifyForRegister extends StatefulWidget {
  const OTPVerifyForRegister({super.key});

  @override
  State<OTPVerifyForRegister> createState() => _OTPVerifyForRegisterState();
}

class _OTPVerifyForRegisterState extends State<OTPVerifyForRegister> {
  final TextEditingController otpController = TextEditingController();

  final OTPController controller = Get.put(OTPController());

  int _secondsRemaining = 60;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _canResend = false;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _canResend = true;
        });
        _timer?.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  void _resendCode() {
    print("Resend OTP code");
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

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
                  text: "Verification Code"),
              SizedBox(height: 4.h),
              CustomText(
                text: "Please enter the code we just sent to your email",
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: Color(0xFF8A8A8A),
              ),
              SizedBox(height: 50),
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
                    GestureDetector(
                      onTap: _canResend ? _resendCode : null,
                      child: CustomText(
                        text: _canResend
                            ? "Resend Code"
                            : "Resend Code ($_secondsRemaining s)",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: _canResend
                            ? AppColors.mainColor
                            : Colors.grey, // grey if disabled
                        underlined: true,
                        underlineColor:
                            _canResend ? AppColors.mainColor : Colors.grey,
                        underlineThickness: 3.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Obx(() {
                return controller.isLoading.value
                    ? Center(
                        child: CustomLoader(),
                      )
                    : SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: CustomButtonWidget(
                          btnColor: AppColors.mainColor,
                          onTap: () {
                            if (otpController.text.isEmpty) {
                              return CustomToast.showToast(
                                  "Please enter your OTP",
                                  isError: true);
                            } else {
                              controller.otpSubmit(
                                  otp: otpController.text, redirect: true);
                            }
                          },
                          iconWant: false,
                          btnText: 'Verify',
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
