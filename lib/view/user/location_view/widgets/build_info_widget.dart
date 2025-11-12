import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';

class BuildInfoWidget extends StatelessWidget {
  final String iconPath;
  final String text;
  final String text1;
  final VoidCallback? tap;

  const BuildInfoWidget({
    super.key,
    required this.iconPath,
    required this.text,
    required this.text1,
     this.tap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                iconPath,
                height: 18.h,
                width: 18.w,
              ),
              SizedBox(width: 10.w),
              CustomText(
                text: text,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AppColors.mainTextColors,
              ),
            ],
          ),
          GestureDetector(
            onTap: tap,
            child: CustomText(
              text: text1,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: const Color(0xFF989898),
            ),
          )
        ],
      ),
    );
  }
}
