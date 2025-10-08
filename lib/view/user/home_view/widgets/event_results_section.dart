import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/comon_conatainer/custom_conatiner.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/app_images.dart';

import 'package:gap/gap.dart';

class EventResultData {
  final String event;
  final String division;
  final String location;
  final String result;

  EventResultData({
    required this.event,
    required this.division,
    required this.location,
    required this.result,
  });
}

class EventResultsSection extends StatelessWidget {
  final List<EventResultData> events;

  const EventResultsSection({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              AppImages.cup,
              height: 20.w,
              width: 20.w,
            ),
            Gap(5.w),
            CustomText(
              color: AppColors.mainTextColors,
              fontWeight: FontWeight.w600,
              fontSize: 14.h,
              text: "Recent Event Results",
            ),
          ],
        ),
        Gap(10.h),
        ...events.map((event) => _buildEventResult(
              event.event,
              event.division,
              event.location,
              event.result,
            )),
      ],
    );
  }

  Widget _buildEventResult(
    String event,
    String division,
    String location,
    String result,
  ) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            color: AppColors.mainTextColors,
            fontWeight: FontWeight.w600,
            fontSize: 14.h,
            text: event,
          ),
          Row(
            children: [
              SizedBox(
                  child: Image.asset(AppImages.calender,
                      height: 14.w, width: 14.w)),
              Gap(4.w),
              CustomText(
                color: const Color(0xFF686868),
                fontWeight: FontWeight.w600,
                fontSize: 12.h,
                text: 'March 15, 2025',
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          child: Image.asset(AppImages.division,
                              height: 14.w, width: 14.w)),
                      Gap(5.w),
                      CustomText(
                        color: const Color(0xFF686868),
                        fontSize: 12.h,
                        text: division,
                      ),
                    ],
                  ),
                  Gap(5.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: const Color(0xFFF2F2F2),
                    ),
                    child: CustomText(
                      color: Color(0xFF686868),
                      fontSize: 12.h,
                      fontWeight: FontWeight.w600,
                      text: "NoGi Absolute",
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          child: Image.asset(AppImages.location,
                              height: 14.w, width: 14.w)),
                      Gap(5.w),
                      CustomText(
                        color: const Color(0xFF686868),
                        fontSize: 12.h,
                        text: location,
                      ),
                    ],
                  ),
                  Gap(5.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.r),
                      color: const Color(0xFFF2F2F2),
                    ),
                    child: CustomText(
                      color: Color(0xFF686868),
                      fontSize: 10.h,
                      fontWeight: FontWeight.w600,
                      text: "Buffalo, New York",
                    ),
                  ),
                ],
              ),
            ],
          ),
          Gap(10.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
              color: Color(0xFFE6E6E6),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.badge,
                    height: 20.h,
                    width: 20.w,
                  ),
                  CustomText(
                    color: AppColors.orangeColor,
                    fontSize: 14.h,
                    fontWeight: FontWeight.w600,
                    text: result,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
