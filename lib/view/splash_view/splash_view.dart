import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../uitilies/app_colors.dart';
import '../../uitilies/app_images.dart';
import 'controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

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
            Image.asset(
              AppImages.logo, // Change to your logo's asset path
              width: 200.w,  // Adjust size as needed
              height: 200.h, // Adjust size as needed
            ),
          ],
        ),
      ),
    );
  }
}
