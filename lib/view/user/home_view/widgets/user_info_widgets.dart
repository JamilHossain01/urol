import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common widget/comon_conatainer/custom_conatiner.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/app_images.dart';
import '../../profile_view/widgets/shimmer/full_image_view_shimmer.dart';

class UserInfoSection extends StatelessWidget {
  final String name;
  final String belt;
  final String gymName;
  final String image;
  final String quote;

  const UserInfoSection({
    super.key,
    required this.name,
    required this.belt,
    required this.gymName,
    required this.quote,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 202.h,
      color: Colors.white,
      child: Column(
        children: [
          _buildUserProfile(),
          Gap(2.h),
          Divider(
            color: Color(0xFF000000).withOpacity(0.10),
          ),
          _buildUserLocation(),
          Divider(
            color: Color(0xFF000000).withOpacity(0.10),
          ),
          _buildUserFavoriteQuote(),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.to(() => FullImageView(imageUrl: image));
          },
          child: CircleAvatar(
            radius: 28.r,
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xFFBC6068),
                  width: 2.w,
                ),
              ),
              child: CircleAvatar(
                radius: 28.r,
                backgroundImage: NetworkImage(image),
              ),
            ),
          ),
        ),
        Gap(10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              color: AppColors.mainTextColors,
              fontWeight: FontWeight.w600,
              fontSize: 20.h,
              text: name,
            ),
            GestureDetector(
                child: Image.asset(
              AppImages.purpelBelt,
              width: 100.w,
              height: 20.h,
            ))
          ],
        ),
      ],
    );
  }

  Widget _buildUserLocation() {
    return Row(
      children: [
        Image.asset(
          AppImages.mapIcon,
          height: 20.h,
          width: 20.w,
        ),
        Gap(10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              color: Color(0xFF8C8C8C),
              fontWeight: FontWeight.w600,
              fontSize: 10.h,
              text: "Home Gym",
            ),
            CustomText(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14.h,
              text: gymName,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserFavoriteQuote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          color: Color(0xFF4B4B4B),
          fontWeight: FontWeight.w500,
          fontSize: 12.h,
          text: "Favorite Quote",
        ),
        Gap(10),
        CustomText(
          color: AppColors.pTextColors,
          fontWeight: FontWeight.w400,
          maxLines: 10,
          textAlign: TextAlign.start,
          fontSize: 12.h,
          text: "${quote}",
        ),
      ],
    );
  }
}
