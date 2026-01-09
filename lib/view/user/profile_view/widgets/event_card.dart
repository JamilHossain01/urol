import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/app_images.dart';
import '../../event_view/recent_event_all_view.dart';
import '../add_compition_view.dart';

class EventCard extends StatelessWidget {
  final String? title;
  final String? date;
  final String? division;
  final String? location;
  final String? medalText;
  final Color? medalColor;
  final Widget medalIcon;
  final bool showCompetition;
  final bool? showAllResult;

  /// 🔴 NEW
  final bool showDeleteButton;
  final VoidCallback? onDelete;

  const EventCard({
    Key? key,
    this.title,
    this.date,
    this.division,
    this.location,
    this.medalText,
    this.medalColor,
    required this.medalIcon,
    this.showCompetition = true,

    /// 🔴 NEW
    this.showDeleteButton = false,
    this.onDelete,
    this.showAllResult,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          /// 🔴 MAIN CONTENT
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title ?? "Event Title",
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
                Divider(color: Colors.black.withOpacity(0.1)),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _eventInfo(
                      "Division",
                      division ?? "N/A",
                      AppImages.division,
                    ),
                    _eventInfo(
                      "Location",
                      location ?? "Unknown",
                      AppImages.Location,
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                /// 🏅 RESULT
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E6E6),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      medalIcon,
                      SizedBox(width: 6.w),
                      CustomText(
                        text: medalText ?? "GOLD",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: medalColor ?? AppColors.orangeColor,
                      ),
                    ],
                  ),
                ),

                /// ➕ ADD COMPETITION
                if (showCompetition) ...[
                  SizedBox(height: 10.h),
                  Divider(color: Colors.black.withOpacity(0.1)),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AddCompetitionResultScreen());
                    },
                    child: Center(
                      child: CustomText(
                        text: "Add Competition Result",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
                if (showAllResult!) ...[
                  SizedBox(height: 10.h),
                  Divider(color: Colors.black.withOpacity(0.1)),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => RecentEventAllView());
                    },
                    child: Center(
                      child: CustomText(
                        text: "See All Results",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          /// 🔴 DELETE BUTTON (TOP-RIGHT)
          if (showDeleteButton)
            Positioned(
              top: 6.h,
              right: 6.w,
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 18.sp,
                  ),
                ),
              ),
            ),
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
            ),
            SizedBox(width: 6.w),
            CustomText(
              text: title,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF4B4B4B),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: CustomText(
            text: value,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF686868),
          ),
        ),
      ],
    );
  }
}
