import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/app_images.dart';

class ProfileHeaderWithBelt extends StatelessWidget {
  final String imageUrl, name;

  const ProfileHeaderWithBelt({
    Key? key,
    required this.imageUrl,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter, // Align the belt below the avatar
          children: [
            // CircleAvatar with border
            CircleAvatar(
              radius: 60.r,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFFBC6068), // Border color
                    width: 2.w, // Border width
                  ),
                ),
                child: CircleAvatar(
                  radius: 55.r, // Slightly smaller radius to fit inside the border
                  backgroundImage: AssetImage(imageUrl),
                ),
              ),
            ),
            // Purple Belt Image under the CircleAvatar
            Positioned(
              bottom: 0,
              child: Image.asset(
                AppImages.purpelBelt, // Belt Image
                width: 100.w,
                height: 20.h,
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              color: AppColors.mainTextColors,
              fontWeight: FontWeight.w600,
              fontSize: 20.h,
              text: name,
            ),
          ],
        ),
      ],
    );
  }
}
