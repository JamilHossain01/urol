import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../common widget/comon_conatainer/custom_conatiner.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/app_images.dart';
import '../../profile_view/widgets/shimmer/full_image_view_shimmer.dart';

class UserInfoSection extends StatelessWidget {
  final String name;
  final String beltRank; // ← API belt rank: "White", "Blue", etc.
  final String gymName;
  final String image;
  final String quote;

  const UserInfoSection({
    super.key,
    required this.name,
    required this.beltRank,
    required this.gymName,
    required this.image,
    required this.quote,
  });

  String get _beltImagePath {
    final rank = beltRank.trim();
    switch (rank) {
      case 'White':
        return "assets/images/White.png";
      case 'Blue':
        return "assets/images/Blue.png";
      case 'Purple':
        return "assets/images/Purple.png";
      case 'Brown':
        return "assets/images/Brown.png";
      case 'Black':
        return "assets/images/Black.png";
      default:
        return "assets/images/Blue.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 190.h,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserProfile(),
          Divider(color: const Color(0xFF000000).withOpacity(0.10)),
          _buildUserLocation(),
          Divider(color: const Color(0xFF000000).withOpacity(0.10)),
          _buildUserFavoriteQuote(),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.to(() => FullImageView(imageUrl: image)),
            child: CircleAvatar(
              radius: 28.r,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: const Color(0xFFBC6068), width: 2.w),
                ),
                child: CircleAvatar(
                  radius: 28.r,
                  backgroundImage: NetworkImage(image),
                  onBackgroundImageError: (_, __) {},
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
                fontSize: 20.sp,
                text: name,
              ),
              Gap(4.h),
              // Dynamic Belt Image
              Image.asset(
                _beltImagePath,
                width: 100.w,
                height: 20.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserLocation() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 4.h),
      child: Row(
        children: [
          Image.asset(AppImages.mapIcon, height: 20.h, width: 20.w),
          Gap(10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                color: const Color(0xFF8C8C8C),
                fontWeight: FontWeight.w600,
                fontSize: 10.sp,
                text: "Home Gym",
              ),
              CustomText(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                text: gymName,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserFavoriteQuote() {
    return Padding(
      padding: EdgeInsets.fromLTRB(6.w, 5.h, 6.w, 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Favorite Quote:",
            color: const Color(0xFF4B4B4B),
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
          CustomText(
            text: '“$quote”', // Smart quotes
            color: AppColors.pTextColors,
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
