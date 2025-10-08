import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/comon_conatainer/custom_conatiner.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/app_images.dart';





class UserInfoSection extends StatelessWidget {
  final String name;
  final String belt;
  final String gymName;
  final String quote;

  const UserInfoSection({
    super.key,
    required this.name,
    required this.belt,
    required this.gymName,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 182.h,
      color: Colors.white,
      child: Column(
        children: [
          _buildUserProfile(),
          Divider(),
          _buildUserLocation(),
          Divider(),
          _buildUserFavoriteQuote(),
        ],
      ),
    );
  }

  Widget _buildUserProfile() {
    return
      Row(
      children: [
        CircleAvatar(
          radius: 28.r,
          backgroundColor: Colors.transparent, // This ensures the background is transparent for the border to be visible
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color(0xFFBC6068), // Change this to your desired border color
                width: 2.w, // Adjust the border width as needed
              ),
            ),
            child: CircleAvatar(
              radius: 28.r, // Slightly smaller radius to fit inside the border
              backgroundImage: AssetImage(AppImages.person),
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
            
            Image.asset(AppImages.purpelBelt,width: 100.w,height: 20.h,)
            
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(50.r),
            //     color: const Color(0xFF8243EE),
            //   ),
            //   child: CustomText(
            //     color: Colors.white,
            //     fontSize: 10.h,
            //     fontWeight: FontWeight.w600,
            //     text: belt,
            //   ),
            // ),
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
