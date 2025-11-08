import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/app_images.dart';
import '../add_compition_view.dart';

class EventCard extends StatelessWidget {
  final String? title;
  final String? date;
  final String? division;
  final String? location;
  final String? medalText;
  final Color? medalColor;
  final String? medalIcon;
  final bool showCompetition;

  const EventCard({
    Key? key,
    this.title,
    this.date,
    this.division,
    this.location,
    this.medalText,
    this.medalColor,
    this.medalIcon,  this.showCompetition = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(0.w),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              // color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text:  title ?? "Event Title",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Image.asset(
                      AppImages.calender,
                      height: 14.h,
                      width: 14.w,
                    ),
                    SizedBox(width: 5.w),
                    CustomText(
                      text: date ?? "Select Date",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF686868),
                    ),
                  ],
                ),
                 Divider(
                  color: Color(0xFF000000).withOpacity(0.10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _eventInfo("Division", division ?? "N/A", AppImages.division),
                    _eventInfo("Location", location ?? "Unknown", AppImages.Location),
                  ],
                ),
                SizedBox(height: 6.h),
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 8.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE6E6E6),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                medalIcon ?? AppImages.badge,
                                height: 20.h,
                                width: 20.w,
                              ),
                              CustomText(
                                color: medalColor ?? AppColors.orangeColor,
                                fontSize: 14.h,
                                fontWeight: FontWeight.w600,
                                text: medalText ?? "GOLD",
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      if(showCompetition)...[
                        Divider(
                          color: Color(0xFF000000).withOpacity(0.10),
                        ),                        GestureDetector(
                          onTap: () {
                            Get.to(() => AddCompetitionResultScreen());
                          },
                          child: CustomText(
                            text: "Add Competition Result",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ]

                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _eventInfo(String title, String value, String iconPath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              iconPath,
              height: 14.h,
              width: 14.w,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 6.w),
            CustomText(
              text: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF4B4B4B),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: CustomText(
            text: value,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF686868),
          ),
        ),
      ],
    );
  }
}
