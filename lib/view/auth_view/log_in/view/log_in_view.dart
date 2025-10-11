import 'package:calebshirthum/view/user/setting/views/privacy_policy.dart';
import 'package:calebshirthum/view/user/setting/views/termOcondition_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_button_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/app_images.dart';
import '../../login_auth_view.dart';
import '../../sign_up_view.dart';



class LogInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Full-screen background image
            Image.asset(
              AppImages.splash,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover, // Ensures the image fills the entire screen
            ),
            // Centered logo (adjust your logo size accordingly)
            // Centered logo (moved 20px upward)
            Positioned(
              top: MediaQuery.of(context).size.height / 2 - 150.h,
              child: Image.asset(
                AppImages.logo,
                width: 200.w,
                height: 200.h,
              ),
            ),

            // Positioned button at the bottom of the screen
            Positioned(
              top: 100,
              left: 100.w,
              right: 100.w,
              child:     CustomText(
                color: Color(0xFF1A1A1A),
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                fontSize: 32.sp,
                text: "Welcome!",
              ),
            ),
            Positioned(
              bottom: 180.h, // Adjust this to control the vertical position of the button
              left: 16.w,
              right: 16.w,
              child: SizedBox(
                height: 55,
                child: CustomButtonWidget(
                  btnColor: AppColors.mainColor,
                  btnTextColor: Colors.white,
                  onTap: () {
                    Get.to(() => SignInView());
                  },
                  iconWant: false,
                  btnText: 'Log In',
                ),
              ),
            ),
            Positioned(
              bottom: 120.h, // Adjust this to control the vertical position of the button
              left: 16.w,
              right: 16.w,
              child: SizedBox(
                height: 55,
                child: CustomButtonWidget(
                  borderColor: AppColors.mainColor,


                  btnTextSize: 14.sp,
                  btnColor: Colors.white,
                  btnTextColor: AppColors.mainColor,
                  onTap: () {
                    Get.to(() => SignUpView());
                  },
                  iconWant: false,
                  btnText: 'Create account',
                ),

              ),
            ),
            Positioned(
              bottom: 80.h, // Adjust this to control the vertical position of the button
              left: 16.w,
              right: 16.w,
              child:  Center(
                child: CustomText(
                  color: Color(0xFF686868),
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                  fontSize: 11.sp,
                  text: "By signing up you confirm that you have read & agree to",
                ),
              ),
            ),   Positioned(
              bottom: 65.h, // Adjust this to control the vertical position of the button
              left: 42.w,
              right: 42.w,
              child:  Row(

                children: [
                  CustomText(
                    color: Color(0xFF686868),
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.start,
                    fontSize: 11.sp,
                    text: "the our",
                  ),
                  Gap(5.w),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=> PrivacyPolicyScreen());
                    },
                    child: CustomText(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start,
                      fontSize: 11.sp,
                      text: "Privacy Policy",
                    ),
                  ),
                  Gap(5.w),


                  CustomText(
                    color: Color(0xFF686868),
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.start,
                    fontSize: 11.sp,
                    text: "and",
                  ),
                  Gap(5.w),

                  GestureDetector(
                    onTap: (){
                      Get.to(()=> TermsConditionsView());
                    },
                    child: CustomText(
                      color: AppColors.mainColor,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.start,
                      fontSize: 11.sp,
                      text: "Terms & conditions",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
