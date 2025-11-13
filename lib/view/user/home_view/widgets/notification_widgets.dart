import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../profile_view/notification_view.dart';

class NotificationBell extends StatelessWidget {
  final int notificationCount; // Dynamic notification count

  NotificationBell({required this.notificationCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => NotificationsScreen());
          },
          child: Container(
            height: 35.h,
            width: 40.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                'assets/images/bell.png',
                height: 24.h,
                width: 24.w,
              ),
            ),
          ),
        ),
        if (notificationCount > 0)
          Positioned(
            top: -4.h,
            right: -4.w,
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.red, // Red background for the badge
                shape: BoxShape.circle, // Circular badge
              ),
              child: Text(
                notificationCount.toString(),
                style: TextStyle(
                  color: Colors.white, // White color for the count
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp, // Adjust font size
                ),
              ),
            ),
          ),
      ],
    );
  }
}
