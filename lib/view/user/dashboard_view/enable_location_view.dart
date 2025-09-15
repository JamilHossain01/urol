// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/constant.dart';
import 'bottom_navigation_view.dart';

class EnableLocationView extends StatelessWidget {
  const EnableLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: CustomAppBar(leading: Container(), title: "Enable Location"),
      body: Padding(
        padding: AppPadding.bodyPadding,
        child: Column(
          children: [
            SizedBox(height: 60.h),
            CustomText(
              color: Color(0xFF1E1E1E),
              fontSize: 20.h,
              fontWeight: FontWeight.w600,
              text: "Enable Location",
            ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image(image: AssetImage(AppImages.enableLocation)),
            ),
            SizedBox(height: 20),
            CustomText(
              color: Color(0xFF1E1E1E),
              fontWeight: FontWeight.w600,
              fontSize: 18.h,
              text: "Location",
            ),
            CustomText(
              color: Color(0xFF8A8A8A),
              fontWeight: FontWeight.w500,

              fontSize: 14.h,
              text:
                  "Your location services are switched off. Please enable location, to help us serve better.",
            ),
            SizedBox(height: 40),
            CustomButtonWidget(
                btnColor: AppColors.mainColor,
                btnText: "Enable Location",
                onTap: () {
                  Get.to(() => DashboardView());
                },
                iconWant: false)
          ],
        ),
      ),
    );
  }
}
