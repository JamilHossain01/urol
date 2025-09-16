import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';

class GymPreviewCard extends StatelessWidget {
  final String image, gymName, location;
  final List<String> categories;

  const GymPreviewCard({
    Key? key,
    required this.image,
    required this.gymName,
    required this.location,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              image,
              height: 120.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Gap(8.h),
          CustomText(
            text: gymName,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.mainTextColors,
          ),
          CustomText(
            text: location,
            fontSize: 12.sp,
            color: Colors.grey,
          ),
          Gap(5.h),
          Wrap(
            spacing: 6.w,
            children: categories.map((category) => _buildChip(category)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: CustomText(
        text: text,
        fontSize: 10.sp,
        color: Colors.black87,
      ),
    );
  }
}
