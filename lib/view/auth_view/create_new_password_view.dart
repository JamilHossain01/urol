// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;

import '../../../uitilies/app_colors.dart';
import '../../common widget/custom text/custom_text_widget.dart';
import '../../common widget/custom_app_bar_widget.dart';
import '../../common widget/custom_button_widget.dart';
import '../../common widget/custom_text_filed.dart';
import 'login_auth_view.dart';

class CreateNewPasswordView extends StatelessWidget {
  const CreateNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Create New Password"),
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

            CustomText(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            text: "New Password"),
        SizedBox(height: 10),
        CustomText(
          text:
          "New password must different from previous",
          color: Colors.grey,
        ),
        SizedBox(height: 10),
        CustomText(
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.start,
          text: "Password",
        ),
        CustomTextField(
          hintText: "Enter your password",
          showObscure: true,
        ),
        SizedBox(height: 10),
        SizedBox(height: 10),
        CustomText(
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.start,
          text: "Confirm Password",
        ),
        CustomTextField(
          hintText: "Enter your password",
          showObscure: true,
        ),
        SizedBox(height: 30),
        SizedBox(
          height: 55,
          width: double.infinity,
          child: CustomButtonWidget(
              btnColor: AppColors.mainColor,

              btnTextColor: Colors.white,

              onTap: ()
          {
          Get.to(() => SignInView());
          },
          iconWant: false,
          btnText: 'Change Password',
        ),
      ),
      SizedBox(height: 20),
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
