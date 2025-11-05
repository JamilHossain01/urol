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
  final String beltRank; // ← Add this

  const ProfileHeaderWithBelt({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.beltRank,
  }) : super(key: key);

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
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Profile Image with Tap to View
            GestureDetector(
              onTap: () {
                Get.to(() => FullImageView(imageUrl: imageUrl));
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
                    onBackgroundImageError: (_, __) {
                      // Optional: show placeholder
                    },
                  ),
                ),
              ),
            ),

            // Dynamic Belt Image
            Positioned(
              bottom: 0,
              child: Image.asset(
                _beltImagePath,
                width: 100.w,
                height: 20.h,
                fit: BoxFit.contain,
              ),
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
