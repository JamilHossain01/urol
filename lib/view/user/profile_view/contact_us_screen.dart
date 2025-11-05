import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/custom_toast.dart';
import 'controller/contact_us_controller.dart';

class ContactScreen extends StatelessWidget {
  ContactScreen({super.key});

  final ContactUsController controller = Get.put(ContactUsController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  // Email regex pattern
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Validate all fields
  String? _validateInputs() {
    if (nameController.text.trim().isEmpty) {
      return "Please enter your name";
    }
    if (emailController.text.trim().isEmpty) {
      return "Please enter your email";
    }
    if (!_emailRegex.hasMatch(emailController.text.trim())) {
      return "Please enter a valid email address";
    }
    if (messageController.text.trim().isEmpty) {
      return "Please enter your message";
    }
    return null; // All good
  }

  void _submit() {
    final error = _validateInputs();
    if (error != null) {
      CustomToast.showToast(error, isError: true);
      return;
    }

    controller.addReflection(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      description: messageController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: CustomAppBar(title: "Contact Us"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Field
            CustomText(
              text: "Name",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              controller: nameController,
              hintText: "Enter your name",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 14.h),

            // Email Field
            CustomText(
              text: "Email",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              controller: emailController,
              hintText: "Enter email address",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 14.h),

            // Message Field
            CustomText(
              text: "Message",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              controller: messageController,
              maxLines: 8,
              hintText: "Enter your message here",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 30.h),

            // Submit Button
            Obx(() {
              return controller.isLoading.value
                  ?  CustomLoader()
                  : CustomButtonWidget(
                btnText: 'Send Message',
                onTap: _submit,
                iconWant: false,
                btnColor: AppColors.mainColor,
              );
            }),
          ],
        ),
      ),
    );
  }
}