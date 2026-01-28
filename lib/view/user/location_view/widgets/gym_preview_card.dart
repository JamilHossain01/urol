import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
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

class GymPreviewCard extends StatelessWidget {
  final String image, gymName, location;
  final List<String> categories;
  final bool showDelete;
  final bool showEdit;
  final String? gymId;
  final Icon? crossIcon;
  final VoidCallback? delete;
  final VoidCallback? editTap;

  // 🔥 NEW FLAGS
  final bool? centerGymName;
  final BoxFit? imageFit;

  const GymPreviewCard({
    Key? key,
    required this.image,
    required this.gymName,
    required this.location,
    required this.categories,
    this.delete,
    required this.showDelete,
    required this.showEdit,
    this.gymId,
    this.editTap,
    this.crossIcon,
    this.centerGymName,
    this.imageFit,
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
                  imageUrl: image,
                  height: 125.h,
                  width: double.infinity,
                  fit: imageFit ?? BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 30.h,
                      width: 30.h,
                      child: CustomLoader(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
              Positioned(
                top: 8.h,
                right: 8.w,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showEdit)
                      GestureDetector(
                        onTap: editTap,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white,
                                width: 1), // optional border
                          ),
                          child: Icon(Icons.edit_road,
                              size: 28, color: Colors.white),
                        ),
                      ),
                    if (showEdit && showDelete) SizedBox(width: 8.w),
                    if (showDelete)
                      GestureDetector(
                        onTap: delete,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: crossIcon ??
                              Icon(Icons.delete_outline_outlined,
                                  size: 28, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Gap(8.h),
          centerGymName!
              ? Center(
                  child: CustomText(
                    textAlign: TextAlign.center,
                    text: gymName,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mainTextColors,
                  ),
                )
              : CustomText(
                  text: gymName,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainTextColors,
                ),
          Gap(2.h),
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
            ],
          ),
          Gap(5.h),
          Wrap(
            spacing: 6.w,
            children:
                categories.map((category) => _buildChip(category)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String text) {
    return Padding(
        padding: EdgeInsets.all(3),
        child: Container(
          margin: EdgeInsets.only(right: 4.w),
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
        ));
  }
}
