import 'package:calebshirthum/view/user/setting/views/privacy_policy.dart';
import 'package:calebshirthum/view/user/setting/views/termOcondition_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
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
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30.h),
                CustomText(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.start,
                  fontSize: 28.sp,
                  text: "Welcome!",
                ),
                SizedBox(height: 40.h),
                Image.asset(
                  "assets/images/new_logo.png",
                  width: 210.w,
                  height: 210.h,
                ),
                SizedBox(height: 110.h),
                SizedBox(
                  height: 55,
                  width: double.infinity,
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
                SizedBox(height: 10.h),
                SizedBox(
                  height: 55,
                  width: double.infinity,
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
                SizedBox(height: 20.h),
                CustomText(
                  color: Color(0xFF686868),
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.start,
                  fontSize: 11.sp,
                  text:
                      "By signing up you confirm that you have read & agree to",
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      onTap: () {
                        Get.to(() => PrivacyPolicyScreen());
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
                      onTap: () {
                        Get.to(() => TermsConditionsView());
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
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ));
  }
}
