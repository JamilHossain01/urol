import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';

class NotificationItem extends StatelessWidget {
  final bool isRead;
  final String title;
  final String subtitle;
  final String time;
  final VoidCallback onTapForSingleTap;

  const NotificationItem({
    super.key,
    required this.isRead,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.onTapForSingleTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTapForSingleTap,
        child: Container(
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
              isRead
                  ? Container()
                  : Container(
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        text: time,
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
