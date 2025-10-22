import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_button_widget.dart';
import '../../../../uitilies/app_colors.dart'; // Ensure to import your custom widgets.

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedEventType = "AGF";
  double distance = 10.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 18,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                CustomText(
                  text: "Filter",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mainTextColors,
                ),
                Container(
                  width: 45,
                )
              ],
            ),
            Gap(15.h),

            // Event Types
            CustomText(
              text: "Event type",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.mainTextColors,
            ),
            Gap(8.h),
            Wrap(
              spacing: 8.w,
              children: ["AGF", "IBJJF", "NAGA", "ADCC", "Local"]
                  .map(
                    (type) => ChoiceChip(
                      backgroundColor: Color(0xFFF5F5F5),
                      label: CustomText(
                        text: type,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: selectedEventType == type
                            ? Colors.white
                            : Colors.black,
                      ),
                      selected: selectedEventType == type,
                      selectedColor: AppColors.mainColor,
                      onSelected: (_) {
                        setState(() {
                          selectedEventType = type;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            Gap(15.h),

            // City / State
            Row(
              children: [
                // State Dropdown
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "State",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainTextColors,
                      ),
                      SizedBox(height: 6.h),
                      SizedBox(
                        height: 50.h,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            hintText: "Select One",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade300, width: 1),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.w),
                          ),
                          items: ["NY", "CA", "TX"]
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (_) {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                // City TextField
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "City",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainTextColors,
                      ),
                      SizedBox(height: 6.h),
                      SizedBox(
                        height: 50.h,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter City",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade300, width: 1),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10.w),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(15.h),

            // Location Distance
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Location Distance",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.mainTextColors,
                ),
                CustomText(
                  text: "Miles",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.pTextColors,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: distance,
                    min: 1,
                    max: 50,
                    divisions: 50,
                    activeColor: AppColors.mainColor,
                    onChanged: (val) {
                      setState(() {
                        distance = val;
                      });
                    },
                  ),
                ),
                CustomText(
                  text: "${distance.toInt()}m",
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ],
            ),
            Gap(15.h),

            // Apply Button
            CustomButtonWidget(
              btnColor: AppColors.mainColor,
              btnTextColor: Colors.white,
              btnText: 'Apply Filter',
              onTap: () => Navigator.pop(context),
              iconWant: false,
            ),
            Gap(10.h),
          ],
        ),
      ),
    );
  }
}
