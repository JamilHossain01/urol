import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_button_widget.dart';
import '../../../../uitilies/app_colors.dart';

class FilterBottomSheet extends StatefulWidget {
  final double distance;
  final List<String> initialEventTypes;

  const FilterBottomSheet(
      {Key? key, required this.distance, required this.initialEventTypes})
      : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  /// ✅ MULTI SELECT EVENT TYPES
  List<String> selectedEventTypes = [];

  // Controllers
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  // Distance
  late double _distance;

  final List<String> eventTypes = [
    "AGF",
    "IBJJF",
    "NAGA",
    "ADCC",
    "Local",
    "Tournament",
    "Seminar",
    "Superfight"
  ];

  @override
  @override
  void initState() {
    super.initState();
    selectedEventTypes = List<String>.from(widget.initialEventTypes);
    _distance = widget.distance;
  }

  void _toggleEventType(String type) {
    setState(() {
      if (selectedEventTypes.contains(type)) {
        selectedEventTypes.remove(type);
      } else {
        selectedEventTypes.add(type);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, size: 18),
                  onPressed: () => Navigator.pop(context),
                ),
                CustomText(
                  text: "Filter",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mainTextColors,
                ),
                const SizedBox(width: 45),
              ],
            ),

            Gap(15.h),

            /// Event Type
            CustomText(
              text: "Event type",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.mainTextColors,
            ),

            Gap(8.h),

            /// ✅ MULTI SELECT UI
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: eventTypes.map((type) {
                final isSelected = selectedEventTypes.contains(type);

                return GestureDetector(
                  onTap: () => _toggleEventType(type),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.mainColor
                          : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? AppColors.mainColor : Colors.grey,
                      ),
                    ),
                    child: CustomText(
                      text: type,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),

            Gap(16.h),

            /// Distance
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
              max: 500,
              divisions: 500,
              activeColor: AppColors.mainColor,
              onChanged: (val) {
                setState(() {
                  _distance = val; // ✅ এই মান bottom sheet খোলা থাকাকালীন ধরে থাকবে
                });
              },
            ),

                ),
                CustomText(
                  text: "${_distance.toInt()}m",
                  fontSize: 12.sp,
                ),
              ],
            ),

            Gap(20.h),

            /// Apply Button
            CustomButtonWidget(
              btnColor: AppColors.mainColor,
              btnTextColor: Colors.white,
              btnText: 'Apply Filter',
              iconWant: false,
              onTap: () {
                print(selectedEventTypes);

                Navigator.pop(context, {
                  "eventTypes": selectedEventTypes,
                  "distance": _distance.toInt(),
                  "city": _cityController.text.trim(),
                  "state": _stateController.text.trim(),
                });
              },
            ),

            Gap(10.h),
          ],
        ),
      ),
    );
  }
}
