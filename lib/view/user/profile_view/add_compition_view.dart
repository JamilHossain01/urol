import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../uitilies/app_colors.dart';

class AddCompetitionResultScreen extends StatelessWidget {
  const AddCompetitionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: CustomAppBar(
        title: "Add Competition Result",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: "Competition Details",
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black),
            SizedBox(height: 14.h),
            CustomText(
              text: "Event Name",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              hintText: "Enter the event name",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,

              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 14.h),
            CustomText(
              text: "Event Date",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
                hintText: "Enter the event date",
                showObscure: false,
                fillColor: AppColors.backRoudnColors,

                hintTextColor: AppColors.hintTextColors,
                suffixIcon: Icons.calendar_month),
            SizedBox(height: 14.h),
            CustomText(
              text: "Division",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                  color: AppColors.backRoudnColors,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Color(0xFFB9B9B9))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: "Purple",
                  items: ["White", "Blue", "Purple", "Brown", "Black"]
                      .map((rank) => DropdownMenuItem(
                            value: rank,
                            child:
                                Text(rank, style: TextStyle(fontSize: 13.sp)),
                          ))
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
            ),
            SizedBox(height: 14.h),
            CustomText(
              text: "Location",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Expanded(
                    child: CustomTextField(
                  hintText: "Enter city",
                  showObscure: false,
                      fillColor: AppColors.backRoudnColors,

                      hintTextColor: AppColors.hintTextColors,
                )),
                SizedBox(width: 12.w),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    decoration: BoxDecoration(
                        color: AppColors.backRoudnColors,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Color(0xFFB9B9B9))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: "Purple",
                        items: ["White", "Blue", "Purple", "Brown", "Black"]
                            .map((rank) => DropdownMenuItem(
                                  value: rank,
                                  child: Text(rank,
                                      style: TextStyle(fontSize: 13.sp)),
                                ))
                            .toList(),
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            CustomText(
              text: "Result",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                  color: AppColors.backRoudnColors,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Color(0xFFB9B9B9))),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: "Purple",
                  items: ["White", "Blue", "Purple", "Brown", "Black"]
                      .map((rank) => DropdownMenuItem(
                            value: rank,
                            child:
                                Text(rank, style: TextStyle(fontSize: 13.sp)),
                          ))
                      .toList(),
                  onChanged: (value) {},
                ),
              ),
            ),
            SizedBox(height: 24.h),
            CustomButtonWidget(
              btnText: 'Save',
              onTap: () {},
              iconWant: false,
              btnColor: AppColors.mainColor,
            )
          ],
        ),
      ),
    );
  }
}
