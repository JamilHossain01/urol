import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';

class FriendsCardWidget extends StatelessWidget {
  final String name;
  final String gym;
  final String imageUrl;
  final List<String> disciplines;
  final VoidCallback onViewTap;

  const FriendsCardWidget({
    super.key,
    required this.name,
    required this.gym,
    required this.imageUrl,
    required this.disciplines,
    required this.onViewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              /// 🖼 Profile Image
              ClipRRect(
                borderRadius: BorderRadius.circular(40.r),
                child: CachedNetworkImage(
                  imageUrl: imageUrl.isNotEmpty
                      ? imageUrl
                      : "https://via.placeholder.com/150",
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

              /// 👤 Friend Details
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
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
            ],
          ),

          SizedBox(height: 8.h),

          /// 🔘 View Button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onViewTap,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
        ],
      ),
    );
  }
}
