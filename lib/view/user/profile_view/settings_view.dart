import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common widget/comon_conatainer/custom_conatiner.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../uitilies/app_images.dart';
import '../setting/views/p_chnage_password_view.dart';

class AccountSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: CustomAppBar(title: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _otherTile("Change Password", AppImages.lock, () {
              Get.to(() => ChangedNewPasswordView());
            }),
            _otherTile("Delete Account", AppImages.delete, () {
              _showDeleteDialog(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _otherTile(String text, String iconPath, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CustomContainer(
        color: const Color(0xFFE9E9E9),
        borderRadius: 8,
        height: 55.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 12.w),
                Image.asset(
                  iconPath,
                  height: 18.h,
                  width: 18.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 10.w),
                CustomText(
                  text: text,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Icon(
                Icons.chevron_right,
                size: 20.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Can dismiss by tapping outside
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [


                // Title
                CustomText(
                  text: 'Delete Account',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),

                // Description
                CustomText(
                  text: 'Are you sure you want to delete your account? This action cannot be undone.',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700]!,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.h),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: CustomContainer(
                          height: 45.h,
                          borderRadius: 8.r,
                          color: Colors.grey[300]!,
                          child: Center(
                            child: CustomText(
                              text: 'Cancel',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          _deleteAccount();
                        },
                        child: CustomContainer(
                          height: 45.h,
                          borderRadius: 8.r,
                          color: Colors.red,
                          child: Center(
                            child: CustomText(
                              text: 'Delete',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteAccount() {
    // TODO: Your delete account logic
    print("Account deleted!");
    Get.snackbar('Deleted', 'Your account has been deleted');
  }
}
