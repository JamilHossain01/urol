import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';

class BuildScheduleWidget extends StatelessWidget {
  final String time;
  final String days;
  final String name;

  const BuildScheduleWidget({
    Key? key,
    required this.time,
    required this.days,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🕒 Time & Days row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: AppColors.mainColor),
                  Gap(5.w),
                  CustomText(
                    text: time,
                    fontSize: 10.sp,
                    color: const Color(0xFF686868),
                  ),
                ],
              ),
              Gap(10.w),
              CustomText(
                text: days,
                fontSize: 10.sp,
                color: const Color(0xFF686868),
              ),
            ],
          ),
          Gap(6.h),
          // 📅 Schedule name
          CustomText(
            text: name,
            fontSize: 16.sp,
            color: AppColors.mainTextColors,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
