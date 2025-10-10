import 'package:calebshirthum/view/user/profile_view/widgets/location_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../uitilies/app_colors.dart';

class AddCompetitionResultScreen extends StatefulWidget {
  const AddCompetitionResultScreen({super.key});

  @override
  State<AddCompetitionResultScreen> createState() => _AddCompetitionResultScreenState();
}

class _AddCompetitionResultScreenState extends State<AddCompetitionResultScreen> {
  @override
  Widget build(BuildContext context) {
    final _cityController = TextEditingController();
    final _stateController = TextEditingController();
    final _zipCodeController = TextEditingController();
    final _streetAddressController = TextEditingController();
    final TextEditingController _dateController = TextEditingController();
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
      );

      if (pickedDate != null) {
        setState(() {
          // Format date as you like
          _dateController.text =
          "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
        });
      }
    }
    ScreenUtil.init(context);
    @override
    void dispose() {
      _dateController.dispose();
      super.dispose();
    }
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
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "Select Event Date",
                suffixIcon: const Icon(Icons.calendar_today),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: Color(0xFFB9B9B9), // 👈 Default border color
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: Color(0xFFB9B9B9), // 👈 Focused border color
                    width: 1,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: Color(0xFFB9B9B9), // 👈 Disabled border color
                    width: 1,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: Color(0xFFB9B9B9), // 👈 Generic border color
                  ),
                ),
              ),
              onTap: () => _selectDate(context),
            ),

            // CustomTextField(
            //   controller: ,
            //     hintText: "Enter the event date",
            //     showObscure: false,
            //     fillColor: AppColors.backRoudnColors,
            //
            //     hintTextColor: AppColors.hintTextColors,
            //     suffixIcon: Icons.calendar_month),
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
                  value: "Gi",
                  items: ["Gi","NoGi", "Gi Absolute", "NoGi Absolute"]
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
            LocationWidget(
              streetAddressController: _streetAddressController,
              cityController: _cityController,
              stateController: _stateController,
              zipCodeController: _zipCodeController,
            ),
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
                  value: "Gold",
                  items: [""
                      "Gold", "Silver", "Bronze", "DNP"]
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
