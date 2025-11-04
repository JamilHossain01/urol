import 'package:action_slider/action_slider.dart';
import 'package:calebshirthum/view/auth_view/log_in/view/log_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../common widget/custom text/custom_text_widget.dart';
import '../../uitilies/app_colors.dart';
import '../../uitilies/app_images.dart';
import '../auth_view/login_auth_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  bool _isLoading = false;
  bool _isSuccess = false;

  void _handleSlider(ActionSliderController sliderController) async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    sliderController.loading();
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _isSuccess = true;
    });

    sliderController.success(); // Success animation
    await Future.delayed(const Duration(milliseconds: 600));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => LogInView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context); // Ensure ScreenUtil is initialized

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// Background Image
          Positioned.fill(
            child: Image.asset(
              AppImages.onBoard,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              AppImages.shadowBlack,
              fit: BoxFit.cover,
            ),
          ),

          /// Bottom Content
          Positioned(
            left: 0,
            right: 0,
            bottom: 40.h,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Everything',
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      CustomText(
                        text: 'jiu jitsu,',
                        color: AppColors.mainColor,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                  CustomText(
                    text: 'on one app.',
                    color: Colors.white,
                    fontSize: 32.sp, // Scalable font size
                    fontWeight: FontWeight.w700,
                  ),

                  Gap(8.h), // Scalable gap
                  CustomText(
                    textAlign: TextAlign.start,
                    maxLines: 10,
                    text:
                        'Browse gyms, find open mats, and stay updated with events and seminars happening in your area!',
                    color: Color(0xFFB5B5B5),
                    fontSize: 13.5.sp, // Scalable font size
                    fontWeight: FontWeight.w400,
                  ),

                  Gap(30.h), // Scalable gap
                  Center(
                    child: ActionSlider.standard(
                      backgroundColor: AppColors.mainColor,
                      toggleColor: Colors.white,
                      icon: Icon(
                        _isSuccess ? Icons.check : Icons.arrow_forward_ios,
                        color: AppColors.mainColor,
                      ),
                      child: CustomText(
                        text: 'Swipe to Get Started',
                        color: Colors.white,
                        fontSize: 16.sp, // Scalable font size
                        fontWeight: FontWeight.bold,
                      ),
                      action: _handleSlider,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
