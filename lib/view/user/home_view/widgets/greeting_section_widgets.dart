import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../uitilies/app_colors.dart';
import '../controller/unread_notification_controller.dart';
import 'notification_widgets.dart';

class GreetingSection extends StatelessWidget {
  GreetingSection({super.key});

  final UnreadNotificationController _unreadNotificationController =
      Get.put(UnreadNotificationController());

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Jiu Jitsu",
              style: GoogleFonts.libreBaskerville(
                fontSize: 16.sp,
                color: AppColors.mainColor,
              ),
            )
          ],
        ),
        Obx(() {
          return NotificationBell(
            notificationCount:
                _unreadNotificationController.unread.value.data ?? 0,
          );
        })
      ],
    );
  }
}
