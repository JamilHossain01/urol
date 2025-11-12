import 'package:cached_network_image/cached_network_image.dart';
import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/custom_loader.dart';
import '../../profile_view/edite_gyms_details.dart';

class MyEventCardWidget extends StatelessWidget {
  final String image, eventName, location, eventDate;
  final bool showEditDelete;
  final VoidCallback? delete;
  final VoidCallback? edit;

  const MyEventCardWidget({
    Key? key,
    required this.image,
    required this.location,
    this.showEditDelete = false,
    this.delete,
    required this.eventName,
    required this.eventDate, this.edit,
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
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  height: 200,
                  imageUrl: image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 25.h,
                      width: 25.w,
                      child: CustomLoader(),
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
              ),
              if (showEditDelete) ...[
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: edit,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            AppImages.e,
                            height: 14.h,
                            width: 16.w,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: delete,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            // color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            AppImages.d, // Replace with actual asset path
                            height: 14.h,
                            width: 16.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
          Gap(8.h),
          CustomText(
            text: eventName,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.mainTextColors,
          ),
          Row(
            children: [
              Image.asset(
                AppImages.location,
                height: 12.h,
                width: 12.w,
              ),
              Gap(4.w),
              CustomText(
                text: location,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4B4B4B),
              ),
              CustomText(
                text: eventDate,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4B4B4B),
              ),
            ],
          ),
          Gap(5.h),
        ],
      ),
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: CustomText(
        text: text,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}
