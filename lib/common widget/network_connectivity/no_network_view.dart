import 'package:app_settings/app_settings.dart';
import 'package:calebshirthum/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart' as AppSettings;
import '../../uitilies/app_colors.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.mainColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Icon container
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainColor.withOpacity(0.15),
                  ),
                  child: Icon(
                    Icons.wifi_off_rounded,
                    size: 72.sp,
                    color: AppColors.mainColor,
                  ),
                ),

                SizedBox(height: 24.h),

                /// Title
                CustomText(
                  text: "No Internet Connection",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),

                SizedBox(height: 12.h),

                /// Subtitle
                CustomText(
                  text:
                      "You're offline. Please check your Wi-Fi \n or mobile data and try again.",
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 32.h),

                /// Retry Button (optional)
                ElevatedButton(
                  onPressed: () {
                    AppSettings.openAppSettings();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 14.h,
                    ),
                  ),
                  child: CustomText(
                    text: "Retry",
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
