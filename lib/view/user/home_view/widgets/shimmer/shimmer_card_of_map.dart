import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../nearby_mats_section.dart';

class ShimmerCardWidgetOfMap extends StatelessWidget {
  const ShimmerCardWidgetOfMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ShimmerWidget.rectangular(
              height: 70.h,
              width: 90.w,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & distance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerWidget.rectangular(
                        height: 14.h,
                        width: 120.w,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      ShimmerWidget.rectangular(
                        height: 12.h,
                        width: 40.w,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  // Days
                  ShimmerWidget.rectangular(
                    height: 12.h,
                    width: 80.w,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  SizedBox(height: 5.h),
                  // Time row
                  Row(
                    children: [
                      ShimmerWidget.rectangular(
                        height: 12.h,
                        width: 14.w,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      SizedBox(width: 4.w),
                      ShimmerWidget.rectangular(
                        height: 12.h,
                        width: 50.w,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ],
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
