import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../uitilies/app_colors.dart';
import 'custom text/custom_text_widget.dart';

class NotFoundWidget extends StatelessWidget {
  final String? imagePath; // optional image
  final IconData? iconData; // optional icon
  final String message; // message text
  final double? imageHeight;
  final double? imageWidth;
  final double? iconSize;
  final Color? iconColor;
  final TextAlign textAlign;

  const NotFoundWidget({
    Key? key,
    this.imagePath,
    this.iconData,
    required this.message,
    this.imageHeight,
    this.imageWidth,
    this.iconSize,
    this.iconColor,
    this.textAlign = TextAlign.center,
  })  : assert(imagePath != null || iconData != null,
            "Either imagePath or iconData must be provided"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          if (imagePath != null)
            Image.asset(
              imagePath!,
              height: imageHeight ?? 100.h,
              width: imageWidth ?? 150.w,
              fit: BoxFit.contain,
            )
          else if (iconData != null)
            Icon(
              iconData,
              size: iconSize ?? 80.sp,
              color: iconColor ?? AppColors.pTextColors,
            ),
          CustomText(
            text: message,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.pTextColors,
            textAlign: textAlign,
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
