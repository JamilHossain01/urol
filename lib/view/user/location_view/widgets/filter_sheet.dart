import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_button_widget.dart';
import '../../../../uitilies/app_colors.dart';

typedef OnApplyFilter = Future<void> Function(
    List<String> selectedCategories, double distance);

class FilterSheet extends StatefulWidget {
  final List<String> selectedCategories;
  final double distance;
  final OnApplyFilter onApply;

  const FilterSheet({
    Key? key,
    required this.selectedCategories,
    required this.distance,
    required this.onApply,
  }) : super(key: key);

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late List<String> _categories;
  late double _distance;

  final List<String> _allCategories = [
    "Open Mat",
    "Jiu Jitsu",
    "Judo",
    "MMA",
    "Wrestling"
  ];

  @override
  void initState() {
    super.initState();
    _categories = List.from(widget.selectedCategories);
    _distance = widget.distance;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Top Bar / Indicator
          Container(
            width: 50.w,
            height: 3.h,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2.5.r),
            ),
          ),
          Gap(10.h),

          /// Header with Title and Close Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 24.w), // space for symmetry
              CustomText(
                  text: "Filter", fontSize: 18.sp, fontWeight: FontWeight.w600),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close, size: 24.sp, color: Colors.black),
              ),
            ],
          ),
          Gap(15.h),

          /// Category Filter
          Wrap(
            spacing: 8.w,
            children: _allCategories
                .map(
                  (cat) => ChoiceChip(
                backgroundColor: AppColors.mainColor,
                selectedColor: AppColors.mainColor,
                label: CustomText(
                  text: cat,
                  fontSize: 12.sp,
                  color: Colors.white, // all labels white
                ),
                selected: _categories.contains(cat),
                onSelected: (_) {
                  setState(() {
                    if (_categories.contains(cat)) {
                      _categories.remove(cat);
                    } else {
                      _categories.add(cat);
                    }
                  });
                },
              ),
            )
                .toList(),
          ),
          Gap(15.h),

          /// Distance Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Location Distance", fontSize: 16.sp),
              CustomText(text: "Miles", fontSize: 14.sp),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _distance,
                  min: 1,
                  max: 100,
                  activeColor: AppColors.mainColor,
                  onChanged: (val) => setState(() => _distance = val),
                ),
              ),
              CustomText(text: "${_distance.toInt()}m", fontSize: 12.sp),
            ],
          ),
          Gap(20.h),

          /// Apply Button
          CustomButtonWidget(
            btnColor: AppColors.mainColor,
            btnTextColor: Colors.white,
            btnText: 'Apply Filter',
            onTap: () async {
              Navigator.pop(context);
              await widget.onApply(_categories, _distance);
            },
            iconWant: false,
          ),
          Gap(20.h),
        ],
      ),
    );
  }
}
