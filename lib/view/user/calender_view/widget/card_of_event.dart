import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';

class CardOfEvent extends StatelessWidget {
  final String image;
  final String date;
  final String title;
  final String org;
  final String location;
  final String daysLeft;
  final String status;
  final String price;
  final String link;

  // Constructor to accept parameters
  const CardOfEvent({
    Key? key,
    required this.image,
    required this.date,
    required this.title,
    required this.org,
    required this.location,
    required this.daysLeft,
    required this.status,
    required this.price,
    required this.link,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Color(0xFFF8F9FA),
        border: Border.all(
          color: Color(0xFF989898),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Event Image with Date Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  bottomLeft: Radius.circular(12.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Image.asset(
                    image,
                    height: 120.h,
                    width: 70.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                left: 20.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: CustomText(
                    text: date,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          // Event Info
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Aligns multi-line text to the top
                    children: [
                      Expanded(
                        child: CustomText(
                          text: title,
                          textAlign: TextAlign.start,
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                          // Prevents overflow errors
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.mainTextColors,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFFF6C6E),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          text: org,
                          fontSize: 10.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),

                  Gap(5.h),

                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: location,
                          fontSize: 12.sp,
                          color: Color(0xFF686868),
                        ),
                      ),
                    ],
                  ),

                  Gap(6.h),

                  // Status Row
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Color(0xFf22C65F),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          text: daysLeft,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Gap(5.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFBB24),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          text: status,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Gap(5.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFB9B9B9),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          text: price,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Gap(6.h),

                  // Link
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CustomText(
                          text: link,
                          fontSize: 10.sp,
                          color: Color(0xFF1D52FF),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          size: 12,
                          color: Color(0xFF1D52FF),
                        )
                      ],
                    ),
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
