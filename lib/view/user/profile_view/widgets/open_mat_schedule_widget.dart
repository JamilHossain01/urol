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
  final String? endTime;
  final List<String> days;
  final List<String> times;
  final ValueChanged<String?> onDayChanged;
  final ValueChanged<String?> onStartTimeChanged;
  final ValueChanged<String?> onEndTimeChanged;
  final VoidCallback onAddMoreDays;
  final VoidCallback? onRemove; // ✅ new optional remove callback
  final bool showClassField;
  final String? addCC;
  final String? name;

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
    this.showClassField = false,
    this.name,
    this.addCC,
    this.onRemove, // ✅ new
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController classNameController = TextEditingController();

    return Container(
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
          /// Title Row (with delete button)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: showClassField ? "Class Schedule" : "Open Mat Schedule",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textFieldNameColor,
              ),
              if (onRemove != null)
                GestureDetector(
                  onTap: onRemove,
                  child: const Icon(Icons.close, color: Colors.red, size: 20),
                ),
            ],
          ),

          Gap(8.h),

          /// Class name field (optional)
          if (showClassField) ...[
            CustomText(
              text: "Class name",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            Gap(4.h),
            CustomTextField(
              controller: classNameController,
              hintText: "Enter the class name",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
              validator: (value) =>
              value!.isEmpty ? "Class name is required" : null,
            ),
            Gap(8.h),
          ],

          /// Day Dropdown
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
                hint: Text("Select a day", style: TextStyle(fontSize: 13.sp)),
                items: days
                    .map((day) => DropdownMenuItem(
                  value: day,
                  child: Text(day, style: TextStyle(fontSize: 13.sp)),
                ))
                    .toList(),
                onChanged: onDayChanged,
              ),
            ),
          ),

          /// Time selection row
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
                  items: times,
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
                  items: times,
                  onChanged: onEndTimeChanged,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          /// Add more button
          GestureDetector(
            onTap: onAddMoreDays,
            child: DottedBorderBox(
              height: 30.h,
              width: double.infinity,
              borderColor: const Color(0xFF989898),
              borderWidth: 2,
              icon: Icons.add,
              iconSize: 24,
              iconColor: const Color(0xFF989898),
              text: addCC ?? "Add More Classes",
              fontSize: 14,
              textColor: const Color(0xFF989898),
              direction: DottedBoxDirection.row,
              spacing: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.backRoudnColors,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFB9B9B9)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xFF989898),
              fontWeight: FontWeight.w400,
            ),
          ),
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
}
