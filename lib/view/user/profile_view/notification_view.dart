import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../uitilies/app_colors.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Notifications',        showLeadingIcon: true,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        children: [
          _buildSection('Today', _buildTodayNotifications()),
          SizedBox(height: 24.h),
          _buildSection('Yesterday', _buildYesterdayNotifications()),
        ],
      ),
    );
  }

  Widget _buildSection(String date, List<Widget> notifications) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: date,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        SizedBox(height: 12.h),
        ...notifications,
      ],
    );
  }

  List<Widget> _buildTodayNotifications() {
    return [
      _buildNotification(
        isRead: true,
        title: 'AGF Tournament in Dallas this weekend-',
        subtitle: 'registration ends tonight!',
        time: '11:00 AM',
      ),
      _buildNotification(
        isRead: true,
        title: 'Open Mat at 10th Planet Austin TX starts in 30',
        subtitle: 'mins—33 people have already checked in.',
        time: '11:00 AM',
      ),
      _buildNotification(
        isRead: false,
        title: 'AGF Tournament in Dallas this weekend-',
        subtitle: 'registration ends tonight!',
        time: '11:00 AM',
      ),
    ];
  }

  List<Widget> _buildYesterdayNotifications() {
    return [
      _buildNotification(
        isRead: true,
        title: 'AGF Tournament in Dallas this weekend-',
        subtitle: 'registration ends tonight!',
        time: '11:00 AM',
      ),
      _buildNotification(
        isRead: true,
        title: 'Open Mat at 10th Planet Austin TX starts in 30',
        subtitle: 'mins—33 people have already checked in.',
        time: '11:00 AM',
      ),
      _buildNotification(
        isRead: false,
        title: 'AGF Tournament in Dallas this weekend-',
        subtitle: 'registration ends tonight!',
        time: '11:00 AM',
      ),
    ];
  }

  Widget _buildNotification({
    required bool isRead,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isRead ? Colors.grey[50] : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8.w,
            height: 8.h,
            margin: EdgeInsets.only(top: 4.h, right: 12.w),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(text: title),
                      TextSpan(
                        text: subtitle,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      text: time,
                      fontSize: 12.sp,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}