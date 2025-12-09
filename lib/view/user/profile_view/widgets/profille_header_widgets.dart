import 'package:calebshirthum/view/user/profile_view/widgets/shimmer/full_image_view_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/app_images.dart';

class ProfileHeaderWithBelt extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? beltRank; // make nullable

  const ProfileHeaderWithBelt({
    Key? key,
    required this.imageUrl,
    required this.name,
    this.beltRank, // nullable now
  }) : super(key: key);

  String? get _beltImagePath {
    final rank = beltRank?.trim() ?? "";

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
        return null; // return null (means show nothing)
    }
  }

  @override
  Widget build(BuildContext context) {
    final beltPath = _beltImagePath;

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Profile Image with Tap
            GestureDetector(
              onTap: () {
                Get.to(() => FullImageView(imageUrls: [imageUrl]));
              },
              child: CircleAvatar(
                radius: 60.r,
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFBC6068),
                      width: 2.w,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 55.r,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ),

            // Dynamic Belt Image (only if exists)
            if (beltPath != null)
              Positioned(
                bottom: 0,
                child: Image.asset(
                  beltPath,
                  width: 110.w,
                  height: 20.h,
                  fit: BoxFit.contain,
                ),
              )
            else
              Positioned(
                bottom: 0,
                child: SizedBox(height: 0, width: 0), // show nothing
              ),
          ],
        ),

        Gap(4.h),

        // Name
        CustomText(
          text: name,
          color: AppColors.mainTextColors,
          fontWeight: FontWeight.w600,
          fontSize: 20.sp,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

