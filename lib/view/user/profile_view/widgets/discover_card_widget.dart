import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../find_friend_profile_view.dart';

class DiscoverCardWidget extends StatelessWidget {
  final String name;
  final String gym;
  final String imageUrl;
  final List<String> disciplines;
  final String followText;
  final Color followColor;
  final VoidCallback onFollowTap;
  final VoidCallback viewTap;

  const DiscoverCardWidget({
    super.key,
    required this.name,
    required this.gym,
    required this.imageUrl,
    required this.disciplines,
    required this.followText,
    required this.followColor,
    required this.onFollowTap,
    required this.viewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image
          ClipRRect(
            borderRadius: BorderRadius.circular(40.r),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 60.w,
              height: 60.h,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 60.w,
                height: 60.h,
                color: Colors.grey[200],
                child: const Icon(Icons.person, color: Colors.grey),
              ),
              errorWidget: (context, url, error) => Container(
                width: 60.w,
                height: 60.h,
                color: Colors.grey[200],
                child: const Icon(Icons.person, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: gym,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 4.h,
                  children: disciplines.map((discipline) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: CustomText(
                        text: discipline,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Buttons Column
          Column(
            children: [
              SizedBox(
                width: 64.w,
                height: 30.h,
                child: TextButton(
                  onPressed: viewTap,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    side: BorderSide(color: AppColors.mainColor),
                  ),
                  child: CustomText(
                    text: 'View',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainColor,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: 64.w,
                height: 30.h,
                child: GestureDetector(
                  onTap: onFollowTap,
                  child: Container(
                    decoration: BoxDecoration(
                      color: followColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: CustomText(
                        text: followText,
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
