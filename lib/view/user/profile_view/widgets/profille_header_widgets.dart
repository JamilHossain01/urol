import 'package:calebshirthum/view/user/profile_view/widgets/shimmer/full_image_view_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          alignment: Alignment.bottomCenter,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FullImageView(imageUrl: imageUrl),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 60.r,
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
                    radius: 55.r,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Image.asset(
                AppImages.purpelBelt,
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
