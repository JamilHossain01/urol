import 'package:calebshirthum/view/user/location_view/widgets/upload_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../uitilies/app_colors.dart';

class ClaimYourGymScreen extends StatelessWidget {
  const ClaimYourGymScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: CustomAppBar(
        title: "Claim Your Gym",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Gym Name",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              hintText: "The Arena Combat Academy",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 14.h),
            CustomText(
              text: "Email",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              hintText: "Enter the email",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 14.h),
            CustomText(
              text: "Phone Number",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              hintText: "+13462127336",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
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
                // City
                // State
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
                ),                        SizedBox(width: 10.w),
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
            SizedBox(height: 14.h),
            CustomText(
              text: "Required Documents",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            CustomText(
              text: "Upload one of these documents to verify ownership.",
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF989898),
            ),
            SizedBox(height: 24.h),
            UploadCard(title: 'Utility Bill'),
            SizedBox(height: 6.h),

            UploadCard(title: 'Business License'),
            SizedBox(height: 6.h),

            UploadCard(title: 'Tax Document'),
            SizedBox(height: 20.h),

            CustomButtonWidget(
              btnText: 'Claim Gym',
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
