import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import 'notification_widgets.dart';
 // Assuming NotificationBell widget is here

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              color: const Color(0xFF686868),
              fontSize: 16.h,
              text: "Hello!",
            ),
            // CustomText(
            //   color: AppColors.mainTextColors,
            //   fontSize: 12.h,
            //   fontWeight: FontWeight.w500,
            //   text: "Good Morning,",
            // ),
          ],
        ),
        NotificationBell(notificationCount: 5), // Notification bell widget here
      ],
    );
  }
}
