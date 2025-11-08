// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:calebshirthum/view/user/home_view/controller/my_profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/constant.dart';
import 'bottom_navigation_view.dart';

class EnableLocationView extends StatelessWidget {
   EnableLocationView({super.key});

  final GetProfileController _getProfileController = Get.put(GetProfileController());

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
            Gap(5.h),
            Text(
              textAlign: TextAlign.center,
              "Your location services are switched off. Please enable location to help us serve you better.",
              style: GoogleFonts.openSans(
                  color: Color(0xFF8A8A8A), fontSize: 11.h),
            ),
            SizedBox(height: 60),
            CustomButtonWidget(
                btnColor: AppColors.mainColor,
                btnText: "Enable Location",
                onTap: () {
                  _getProfileController.getProfileController();
                  Get.to(() => DashboardView());

                },
                iconWant: false)
          ],
        ),
      ),
    );
  }
}
