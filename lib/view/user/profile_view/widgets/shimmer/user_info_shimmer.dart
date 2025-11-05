import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class UserInfoCardShimmer extends StatelessWidget {
  const UserInfoCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🏠 Home Gym shimmer
          _buildSectionShimmer(
            child: Row(
              children: [
                Container(
                  height: 38.h,
                  width: 38.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmerBox(width: 80.w, height: 10.h),
                    SizedBox(height: 5.h),
                    _shimmerBox(width: 150.w, height: 12.h),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 15.h),

          /// 📏 Height and Weight Row shimmer
          _buildSectionShimmer(
            child: Row(
              children: [
                Expanded(child: _infoTileShimmer()),
                SizedBox(width: 10.w),
                Expanded(child: _infoTileShimmer()),
              ],
            ),
          ),

          SizedBox(height: 15.h),

          /// 🎯 Skills Section shimmer
          _buildSectionShimmer(
            child: Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: List.generate(
                4,
                    (index) => _shimmerBox(width: 70.w, height: 24.h),
              ),
            ),
          ),

          SizedBox(height: 15.h),

          /// 🧠 Favorite Quote + Button shimmer
          _buildSectionShimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: Colors.grey.shade300),
                SizedBox(height: 6.h),
                _shimmerBox(width: 100.w, height: 12.h),
                SizedBox(height: 10.h),
                _shimmerBox(width: double.infinity, height: 10.h),
                SizedBox(height: 6.h),
                _shimmerBox(width: 200.w, height: 10.h),
                SizedBox(height: 15.h),
                _shimmerBox(width: double.infinity, height: 40.h, radius: 8.r),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🌀 Reusable shimmer wrapper
  Widget _buildSectionShimmer({required Widget child}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child,
    );
  }

  /// 🧱 Info tile shimmer block
  Widget _infoTileShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Container(
              height: 20.h,
              width: 20.w,
              color: Colors.grey.shade300,
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _shimmerBox(width: 40.w, height: 8.h),
                SizedBox(height: 4.h),
                _shimmerBox(width: 60.w, height: 10.h),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 🔲 Shimmer box utility
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
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }
}
