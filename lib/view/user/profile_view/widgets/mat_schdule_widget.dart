import 'package:calebshirthum/common%20widget/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_text_filed.dart';
import '../../../../common widget/dot_border_container.dart';
import '../../../../uitilies/app_colors.dart';

class MatScheduleWidget {
  final String className;
  final String day;
  final String startTime;
  final String endTime;

  MatScheduleWidget({
    required this.className,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  @override
  String toString() => "$className - $day ($startTime to $endTime)";
}

class MatScheduleWidgetWidget extends StatefulWidget {
  final List<String> days;
  final List<String> times;
  final Function(MatScheduleWidget)? onScheduleAdded;

  const MatScheduleWidgetWidget({
    super.key,
    required this.days,
    required this.times,
    this.onScheduleAdded,
  });

  @override
  State<MatScheduleWidgetWidget> createState() =>
      _MatScheduleWidgetWidgetState();
}

class _MatScheduleWidgetWidgetState extends State<MatScheduleWidgetWidget> {
  String? selectedDay;
  String? startTime;
  String? endTime;
  final TextEditingController classNameController = TextEditingController();

  List<MatScheduleWidget> schedules = [];

  void onDayChanged(String? value) {
    setState(() {
      selectedDay = value;
    });
  }

  void onStartTimeChanged(String? value) {
    setState(() {
      startTime = value;
    });
  }

  void onEndTimeChanged(String? value) {
    setState(() {
      endTime = value;
    });
  }

  Widget _buildTimeDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.backRoudnColors,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFB9B9B9)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: TextStyle(fontSize: 13.sp)),
          isExpanded: true,
          items: items
              .map((time) => DropdownMenuItem(
                    value: time,
                    child: Text(time, style: TextStyle(fontSize: 13.sp)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: const Color(0xFFDADADA)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Open Mat Schedule",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              Gap(8.h),

              // Day Dropdown
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
                  border: Border.all(color: const Color(0xFFB9B9B9)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedDay,
                    hint:
                        Text("Select a day", style: TextStyle(fontSize: 13.sp)),
                    isExpanded: true,
                    items: widget.days
                        .map((day) => DropdownMenuItem(
                              value: day,
                              child:
                                  Text(day, style: TextStyle(fontSize: 13.sp)),
                            ))
                        .toList(),
                    onChanged: onDayChanged,
                  ),
                ),
              ),

              // Time selection row
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
                    child: _buildTimeDropdown(
                      hint: "Start",
                      value: startTime,
                      items: widget.times,
                      onChanged: onStartTimeChanged,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text("to",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF989898),
                          fontWeight: FontWeight.w500)),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: _buildTimeDropdown(
                      hint: "End",
                      value: endTime,
                      items: widget.times,
                      onChanged: onEndTimeChanged,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Gap(12.h),

              GestureDetector(
                onTap: () {
                  if (selectedDay == null ||
                      startTime == null ||
                      endTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }

                  final schedule = MatScheduleWidget(
                    className: classNameController.text,
                    day: selectedDay!,
                    startTime: startTime!,
                    endTime: endTime!,
                  );

                  // Clear inputs
                  classNameController.clear();
                  selectedDay = null;
                  startTime = null;
                  endTime = null;

                  // Notify parent
                  if (widget.onScheduleAdded != null) {
                    widget.onScheduleAdded!(schedule);
                  }
                },
                child: DottedBorderBox(
                  height: 30.h,
                  width: double.infinity,
                  borderColor: const Color(0xFF989898),
                  borderWidth: 2,
                  iconSize: 24,
                  iconColor: const Color(0xFF989898),
                  text: "Add More Schedule",
                  fontSize: 14,
                  textColor: const Color(0xFF989898),
                  direction: DottedBoxDirection.row,
                  spacing: 8,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
