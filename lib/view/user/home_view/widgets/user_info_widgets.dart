import 'package:cached_network_image/cached_network_image.dart';
import 'package:calebshirthum/common%20widget/custom_elipse_text.dart';
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
  final String? beltRank;
  final String gymName;
  final String image;
  final String weight;
  final String height;
  final String quote;
  final List<String> skills;

  const UserInfoSection({
    super.key,
    required this.name,
    required this.beltRank,
    required this.gymName,
    required this.image,
    required this.quote,
    required this.weight,
    required this.height,
    required this.skills,
  });

  /// RETURN NULL WHEN NO VALID BELT — SO NOTHING IS SHOWN
  String? get _beltImagePath {
    final rank = (beltRank ?? "").trim();

    switch (rank) {
      case 'White':
        return "assets/icon/white_high.png";
      case 'Blue':
        return "assets/icon/blue_high.png";
      case 'Purple':
        return "assets/icon/purple_high.png";
      case 'Brown':
        return "assets/icon/brown_high.png";
      case 'Black':
        return "assets/icon/black_high.png";
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.transparent,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserProfile(),
          SizedBox(height: 10),
          Row(
            children: [
              _infoTile(AppImages.scale, "Height", "${height}"),
              Gap(10.w),
              _infoTile(AppImages.kg, "Weight", "${weight} lb"),
            ],
          ),
          SizedBox(height: 10),
          skills.isEmpty
              ? SizedBox.shrink()
              : Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: skills.map(_skillChip).toList(),
                ),
          Divider(color: const Color(0xFF000000).withOpacity(0.10)),
          _buildUserLocation(),
          Divider(color: const Color(0xFF000000).withOpacity(0.10)),
          _buildUserFavoriteQuote(),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    final beltPath = _beltImagePath;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.to(() => FullImageView(imageUrls: [image])),
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
                  backgroundImage: CachedNetworkImageProvider(image),
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

              // SHOW BELT ONLY IF VALID
              if (beltPath != null)
                Image.asset(
                  beltPath,
                  width: 100.w,
                  height: 20.h,
                  fit: BoxFit.contain,
                )
              else
                SizedBox.shrink(), // nothing shown
            ],
          ),
        ],
      ),
    );
  }

  Widget _skillChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: CustomText(
        text: text,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.mainColor,
      ),
    );
  }

  /// 🔹 Info Tile for Height / Weight
  Widget _infoTile(String iconPath, String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, height: 20.h, width: 20.w),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: label,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.pTextColors,
                ),
                CustomText(
                  text: value,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
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
            textAlign: TextAlign.start,
            text: customEllipsisText('“$quote”', wordLimit: 12),
            color: AppColors.pTextColors,
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
