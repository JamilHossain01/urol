import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_text_filed.dart';
import '../../../../common widget/dot_border_container.dart';
import '../../../../uitilies/app_colors.dart';



class OpenMatScheduleWidget extends StatelessWidget {
  final String? selectedDay;
  final String? startTime;
  final String? name;
  final String? addCC;
  final String? endTime;
  final List<String> days;
  final List<String> times;
  final ValueChanged<String?> onDayChanged;
  final ValueChanged<String?> onStartTimeChanged;
  final ValueChanged<String?> onEndTimeChanged;
  final VoidCallback onAddMoreDays;
  final bool showClassField;

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
    required this.onAddMoreDays, this.showClassField = false, this.name, this.addCC,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController streetAddressController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: name??"Open Mat Schedule",
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        SizedBox(height: 8.h),
        if(showClassField)...[
          CustomText(
            text: "Class Schedule",
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textFieldNameColor,
          ),
          Gap(4.h),



          CustomTextField(
            controller: streetAddressController,
            hintText: "Enter the class name",
            showObscure: false,
            fillColor: AppColors.backRoudnColors,
            hintTextColor: AppColors.hintTextColors,
            validator: (value) => value!.isEmpty ? "Address is required" : null,
          ),
        ],



        CustomText(
          text: "Day",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        Gap(4.h),

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
              hint: Text("Select a day", style: TextStyle(fontSize: 13.sp)),
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
        Gap(4.h),

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
                    hint: Text("12:30 PM", style: TextStyle(fontSize: 12.sp,color: Color(0xFF989898),fontWeight: FontWeight.w400)),
                    items: times.map((time) => DropdownMenuItem(
                      value: time,
                      child: Text(time, style: TextStyle(fontSize: 13.sp)),
                    )).toList(),
                    onChanged: onStartTimeChanged,
                  ),
                ),
              ),
            ),
            SizedBox(width: 4.w),

            Text("to", style:
            TextStyle(fontSize: 14.sp,color: Color(0xFF989898),fontWeight: FontWeight.w500)),
            SizedBox(width: 4.w),
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
                    hint: Text("2:30 PM", style:  TextStyle(fontSize: 12.sp,color: Color(0xFF989898),fontWeight: FontWeight.w400)),
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
        DottedBorderBox(
          height: 30.h,
          width: double.infinity,
          borderColor: Color(0xFF989898),
          borderWidth: 2,
          icon: Icons.add,
          iconSize: 24,
          iconColor: Color(0xFF989898),
          text: addCC ?? "Add More Classes",
          fontSize: 14,
          textColor: Color(0xFF989898),
          direction: DottedBoxDirection.row,
          spacing: 8,
        ),        SizedBox(height: 20.h),
      ],
    );
  }
}