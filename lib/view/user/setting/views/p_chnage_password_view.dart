// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/uitilies/custom_toast.dart';
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
import '../../profile_view/controller/change_password_controller.dart';

class ChangedNewPasswordView extends StatelessWidget {
  ChangedNewPasswordView({super.key});

  final ChnagePasswordController _changePassC =
      Get.put(ChnagePasswordController());

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                child: SingleChildScrollView(
                  // Added SingleChildScrollView here
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
                        controller: oldPasswordController,
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
                        controller: newPasswordController,
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
                        controller: confirmPasswordController,
                        hintText: "Confirm Password",
                        showObscure: true,
                        fillColor: AppColors.backRoudnColors,
                        hintTextColor: AppColors.hintTextColors,
                      ),
                      SizedBox(height: 30),
                      Obx(() {
                        return _changePassC.isLoading.value
                            ?  CustomLoader()
                            : SizedBox(
                          height: 55.h,
                          width: double.infinity,
                          child: CustomButtonWidget(
                            btnColor: AppColors.mainColor,
                            onTap: () {
                              final oldPass = oldPasswordController.text.trim();
                              final newPass = newPasswordController.text.trim();
                              final confirmPass = confirmPasswordController.text.trim();

                              // 1. Check empty fields
                              if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
                                CustomToast.showToast("All fields are required", isError: true);
                                return;
                              }

                              // 2. Check password match
                              if (newPass != confirmPass) {
                                CustomToast.showToast("Passwords do not match", isError: true);
                                return;
                              }

                              // 3. STRONG PASSWORD CHECK (DIRECT LOGIC — NO FUNCTION CALL)
                              if (newPass.length < 8 ||
                                  !RegExp(r'[A-Z]').hasMatch(newPass) ||
                                  !RegExp(r'[0-9]').hasMatch(newPass) ||
                                  !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(newPass)) {
                                CustomToast.showToast(
                                  "Password must be 8+ chars with uppercase, number & special character",
                                  isError: true,
                                );
                                return;
                              }

                              // 4. All good → Call API
                              _changePassC.passwordChange(
                                oldPass: oldPass,
                                newPass: newPass,
                                confirmPass: confirmPass,
                              );
                            },
                            iconWant: false,
                            btnText: 'Save',
                          ),
                        );
                      }),
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
}
