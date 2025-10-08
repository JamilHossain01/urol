import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';



class OpenMatScheduleWidget extends StatelessWidget {
  final String? selectedDay;
  final String? startTime;
  final String? endTime;
  final List<String> days;
  final List<String> times;
  final ValueChanged<String?> onDayChanged;
  final ValueChanged<String?> onStartTimeChanged;
  final ValueChanged<String?> onEndTimeChanged;
  final VoidCallback onAddMoreDays;

  const OpenMatScheduleWidget({
    super.key,
    required this.selectedDay,
    required this.startTime,
    required this.endTime,
    required this.days,
    required this.times,
    required this.onDayChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    required this.onAddMoreDays,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Open Mat Schedule",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        SizedBox(height: 12.h),
        CustomText(
          text: "Day",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            color: AppColors.backRoudnColors,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Color(0xFFB9B9B9)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedDay,
              hint: Text("mon", style: TextStyle(fontSize: 13.sp)),
              items: days.map((day) => DropdownMenuItem(
                value: day,
                child: Text(day, style: TextStyle(fontSize: 13.sp)),
              )).toList(),
              onChanged: onDayChanged,
            ),
          ),
        ),
        CustomText(
          text: "Time",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                margin: EdgeInsets.only(right: 8.w),
                decoration: BoxDecoration(
                  color: AppColors.backRoudnColors,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Color(0xFFB9B9B9)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: startTime,
                    hint: Text("12:30 PM", style: TextStyle(fontSize: 13.sp)),
                    items: times.map((time) => DropdownMenuItem(
                      value: time,
                      child: Text(time, style: TextStyle(fontSize: 13.sp)),
                    )).toList(),
                    onChanged: onStartTimeChanged,
                  ),
                ),
              ),
            ),
            Text("to", style: TextStyle(fontSize: 14.sp)),
            SizedBox(width: 8.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                margin: EdgeInsets.only(left: 8.w),
                decoration: BoxDecoration(
                  color: AppColors.backRoudnColors,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Color(0xFFB9B9B9)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: endTime,
                    hint: Text("2:30 PM", style: TextStyle(fontSize: 13.sp)),
                    items: times.map((time) => DropdownMenuItem(
                      value: time,
                      child: Text(time, style: TextStyle(fontSize: 13.sp)),
                    )).toList(),
                    onChanged: onEndTimeChanged,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: onAddMoreDays,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFFB9B9B9), width: 1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 16.sp, color: Color(0xFFB9B9B9)),
                SizedBox(width: 4.w),
                CustomText(
                  text: "Add More Days",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFB9B9B9),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}