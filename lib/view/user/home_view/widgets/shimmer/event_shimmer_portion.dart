// event_card_shimmer.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class EventCardShimmer extends StatelessWidget {
  const EventCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBox(width: 150.w, height: 18.h), // Title
          SizedBox(height: 10.h),

          Row(
            children: [
              _circleShimmer(16.w),
              SizedBox(width: 8.w),
              _shimmerBox(width: 100.w, height: 14.h), // Date
            ],
          ),

          SizedBox(height: 10.h),
          Divider(color: Colors.black.withOpacity(0.1)),

          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoShimmer(), // Division
              _infoShimmer(), // Location
            ],
          ),

          SizedBox(height: 16.h),

          // Medal container
          _shimmerBox(width: double.infinity, height: 40.h),

          SizedBox(height: 10.h),
          Divider(color: Colors.black.withOpacity(0.1)),

          SizedBox(height: 10.h),
          Center(
            child: _shimmerBox(width: 140.w, height: 16.h), // "Add Competition Result"
          ),
        ],
      ),
    );
  }

  // ---- Shimmer Widgets -----

  Widget _shimmerBox({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  Widget _circleShimmer(double size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _infoShimmer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _shimmerBox(width: 80.w, height: 12.h),
        SizedBox(height: 6.h),
        _shimmerBox(width: 90.w, height: 20.h),
      ],
    );
  }
}
