import 'package:calebshirthum/view/user/setting/views/privacy_policy.dart';
import 'package:calebshirthum/view/user/setting/views/termOcondition_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_app_bar_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../profile_view/settings_view.dart';
import '../controllers/setting_controller.dart';
import '../widgets/setting_item.dart';
import 'about_view.dart';

// Reusable Setting Item Widget


class SettingView extends GetView<SettingController> {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingController controller = Get.put(SettingController());
    return Scaffold(
      appBar: CustomAppBar(title: 'Settings'),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          // Settings Header
          CustomText(
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
            textAlign: TextAlign.start,
            text: 'Settings',
            color: AppColors.mainTextColors,

          ),
          // SizedBox(height: 16.0),

          // Edit Profile
          SettingItem(
            title: 'Edit Profile',
            trailing: Icon(Icons.chevron_right, color: Colors.black),
            onTap: () {
              // Get.to(()=>EditProfileScreen());

            },
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),

          // Notification with Switch
          Obx(() => SettingItem(
            title: 'Notification',
            trailing: Switch(
              value: controller.notificationValue.value, // Example state from controller
              onChanged: (value) => controller.toggleNotification(value),
              activeColor: Colors.blue,
            ),
            onTap: () {},
          )),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),

          // Account Setting
          SettingItem(
            title: 'Account Setting',
            trailing: Icon(Icons.chevron_right, color: Colors.black),
            onTap: () {
              Get.to(()=>AccountSettingsScreen());

            },
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          SizedBox(height: 8.h,),

          // Legal Header
          CustomText(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            textAlign: TextAlign.start,
            text: 'Legal',
            color: AppColors.textFieldNameColor,
          ),

          // Term & Conditions
          SettingItem(
            title: 'Term & Conditions',
            trailing: Icon(Icons.chevron_right, color: Colors.black),
            onTap: () {
              Get.to(()=>TermsConditionsView());

            },
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),

          // Privacy Policy
          SettingItem(
            title: 'Privacy Policy',
            trailing: Icon(Icons.chevron_right, color: Colors.black),
            onTap: () {
              Get.to(()=>PrivacyPolicyScreen());

            },
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),

          // About Us
          SettingItem(
            title: 'About Us',
            trailing: Icon(Icons.chevron_right, color: Colors.black),
            onTap: () {
              Get.to(()=>AboutUsView());

            },
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),

          // Delete Account
          SettingItem(
            title: 'Delete Account',
            trailing: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.delete, color: AppColors.bgColor, size: 16),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}