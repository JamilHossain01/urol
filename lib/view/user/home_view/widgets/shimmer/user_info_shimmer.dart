import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../common widget/comon_conatainer/custom_conatiner.dart';

class UserInfoSectionShimmer extends StatelessWidget {
  const UserInfoSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 202.h,
      color: Colors.white,
      child: Column(
        children: [
          _buildProfileShimmer(),
          Gap(2.h),
          Divider(color: const Color(0xFF000000).withOpacity(0.10)),
          _buildLocationShimmer(),
          Divider(color: const Color(0xFF000000).withOpacity(0.10)),
          _buildQuoteShimmer(),
        ],
      ),
    );
  }

  /// 🧍 Profile shimmer
  Widget _buildProfileShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        children: [
          // Profile Image Placeholder
          Container(
            height: 56.h,
            width: 56.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400, width: 2.w),
            ),
          ),
          Gap(10.w),

          // Name and Belt shimmer
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(width: 120.w, height: 16.h, radius: 6.r),
              Gap(8.h),
              _shimmerBox(width: 100.w, height: 18.h, radius: 4.r),
            ],
          ),
        ],
      ),
    );
  }

  /// 📍 Location shimmer
  Widget _buildLocationShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        children: [
          Container(
            height: 20.h,
            width: 20.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          Gap(10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shimmerBox(width: 60.w, height: 10.h),
              Gap(5.h),
              _shimmerBox(width: 150.w, height: 12.h),
            ],
          ),
        ],
      ),
    );
  }

  /// 🧠 Favorite Quote shimmer
  Widget _buildQuoteShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerBox(width: 100.w, height: 12.h),
          Gap(10.h),
          _shimmerBox(width: double.infinity, height: 10.h),
          Gap(6.h),
          _shimmerBox(width: double.infinity, height: 10.h),
          Gap(6.h),
          _shimmerBox(width: 200.w, height: 10.h),
        ],
      ),
    );
  }

  /// 🧩 Reusable shimmer box
  Widget _shimmerBox({
    double? width,
    double? height,
    double radius = 4,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
