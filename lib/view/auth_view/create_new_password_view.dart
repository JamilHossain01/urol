// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/view/auth_view/controller/create_password_controller.dart';
import 'package:calebshirthum/view/auth_view/login_auth_view.dart';
import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../uitilies/app_colors.dart';
import '../../common widget/custom text/custom_text_widget.dart';
import '../../common widget/custom_app_bar_widget.dart';
import '../../common widget/custom_button_widget.dart';
import '../../common widget/custom_text_filed.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  final CreatePasswordController _controller =
      Get.put(CreatePasswordController());

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isStrongPassword(String password) {
    return password.length >= 8;
  }

  void _submitNewPassword() {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      CustomToast.showToast("All fields are required", isError: true);
      return;
    }

    if (!_isStrongPassword(password)) {
      CustomToast.showToast(
        "Password must include at least 8 characters!",
        isError: true,
      );
      return;
    }

    if (password != confirmPassword) {
      CustomToast.showToast("Passwords do not match!", isError: true);
      return;
    }

    _controller.createPass(
        newPassword: password, confirmPassword: confirmPassword);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    CustomText(
                        fontWeight: FontWeight.w600,
                        fontSize: 32.sp,
                        text: "New Password"),
                    SizedBox(height: 8),
                    CustomText(
                      text: "New password must be different from previous",
                      color: Color(0xFF8A8A8A),
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                    SizedBox(height: 15),

                    // New Password Field
                    CustomText(
                      text: "New Password",
                      fontSize: 12.sp,
                      color: AppColors.pTextColors,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      hintText: "Enter your password",
                      showObscure: true,
                    ),
                    SizedBox(height: 10),

                    // Confirm Password Field
                    CustomText(
                      fontSize: 12.sp,
                      color: AppColors.pTextColors,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start,
                      text: "Confirm Password",
                    ),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      hintText: "Enter your password again",
                      showObscure: true,
                    ),
                    SizedBox(height: 30),

                    // Submit Button
                    Obx(() {
                      return SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: _controller.isLoading.value
                            ? CustomLoader()
                            : CustomButtonWidget(
                                btnColor: AppColors.mainColor,
                                btnTextColor: Colors.white,
                                onTap: _submitNewPassword,
                                iconWant: false,
                                btnText: 'Change Password',
                              ),
                      );
                    }),
                    SizedBox(height: 20),
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
