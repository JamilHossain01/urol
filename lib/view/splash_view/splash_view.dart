import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/icon/oneSplash.jpg",
              fit: BoxFit.cover,
            ),
          ),

          /// Logo at center
          Center(
            child: Image.asset(
              "assets/icon/name_with_logo.png",
              width: 250.w,   // responsive size
              height: 250.w,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
