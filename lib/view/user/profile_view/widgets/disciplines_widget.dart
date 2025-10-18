import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';

class DisciplinesWidget extends StatelessWidget {
  final List<String> selectedDisciplines;
  final Function(List<String>) onSelectionChanged;

  const DisciplinesWidget({
    super.key,
    required this.selectedDisciplines,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Disciplines",
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            FilterChip(
              label: Text(
                "Jiu Jitsu",
                style: TextStyle(
                  color: selectedDisciplines.contains("Jiu Jitsu")
                      ? Colors.white
                      : AppColors.textFieldNameColor,
                ),
              ),
              selected: selectedDisciplines.contains("Jiu Jitsu"),
              onSelected: (selected) {
                final updated = List<String>.from(selectedDisciplines);
                if (selected) {
                  updated.add("Jiu Jitsu");
                } else {
                  updated.remove("Jiu Jitsu");
                }
                onSelectionChanged(updated);
              },
              selectedColor: AppColors.mainColor,
              checkmarkColor: Colors.white,
            ),
            FilterChip(
              label: Text(
                "Wrestling",
                style: TextStyle(
                  color: selectedDisciplines.contains("Wrestling")
                      ? Colors.white
                      : AppColors.textFieldNameColor,
                ),
              ),
              selected: selectedDisciplines.contains("Wrestling"),
              onSelected: (selected) {
                final updated = List<String>.from(selectedDisciplines);
                if (selected) {
                  updated.add("Wrestling");
                } else {
                  updated.remove("Wrestling");
                }
                onSelectionChanged(updated);
              },
              selectedColor: AppColors.mainColor,
              checkmarkColor: Colors.white,
            ),
            FilterChip(
              label: Text(
                "MMA",
                style: TextStyle(
                  color: selectedDisciplines.contains("MMA")
                      ? Colors.white
                      : AppColors.textFieldNameColor,
                ),
              ),
              selected: selectedDisciplines.contains("MMA"),
              onSelected: (selected) {
                final updated = List<String>.from(selectedDisciplines);
                if (selected) {
                  updated.add("MMA");
                } else {
                  updated.remove("MMA");
                }
                onSelectionChanged(updated);
              },
              selectedColor: AppColors.mainColor,
              checkmarkColor: Colors.white,
            ),
            FilterChip(
              label: Text(
                "Judo",
                style: TextStyle(
                  color: selectedDisciplines.contains("Judo")
                      ? Colors.white
                      : AppColors.textFieldNameColor,
                ),
              ),
              selected: selectedDisciplines.contains("Judo"),
              onSelected: (selected) {
                final updated = List<String>.from(selectedDisciplines);
                if (selected) {
                  updated.add("Judo");
                } else {
                  updated.remove("Judo");
                }
                onSelectionChanged(updated);
              },
              selectedColor: AppColors.mainColor,
              checkmarkColor: Colors.white,
            ),
            FilterChip(
              label: Text(
                "Muay Thai",
                style: TextStyle(
                  color: selectedDisciplines.contains("Muay Thai")
                      ? Colors.white
                      : AppColors.textFieldNameColor,
                ),
              ),
              selected: selectedDisciplines.contains("Muay Thai"),
              onSelected: (selected) {
                final updated = List<String>.from(selectedDisciplines);
                if (selected) {
                  updated.add("Muay Thai");
                } else {
                  updated.remove("Muay Thai");
                }
                onSelectionChanged(updated);
              },
              selectedColor: AppColors.mainColor,
              checkmarkColor: Colors.white,
            ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
