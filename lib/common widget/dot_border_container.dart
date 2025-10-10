import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';

enum DottedBoxDirection { column, row }

class DottedBorderBox extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final Widget? child;
  final Color backgroundColor;

  // Icon customization
  final IconData icon;
  final double iconSize;
  final Color iconColor;

  // Text customization
  final String text;
  final double fontSize;
  final Color textColor;
  final FontWeight fontWeight;

  // Layout direction
  final DottedBoxDirection direction;
  final double spacing; // spacing between icon and text

  const DottedBorderBox({
    Key? key,
    this.height = 90,
    this.width = 120,
    this.borderRadius = 8,
    this.borderColor = Colors.grey,
    this.borderWidth = 1,
    this.child,
    this.backgroundColor = Colors.white,
    this.icon = Icons.add,
    this.iconSize = 22,
    this.iconColor = Colors.grey,
    this.text = "Upload",
    this.fontSize = 13,
    this.textColor = Colors.grey,
    this.fontWeight = FontWeight.w500,
    this.direction = DottedBoxDirection.column,
    this.spacing = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(borderRadius.r),
      dashPattern: [6, 3],
      color: borderColor,
      strokeWidth: borderWidth,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        child: child ??
            Center(
              child: direction == DottedBoxDirection.column
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: iconColor, size: iconSize),
                  SizedBox(height: spacing.h),
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize.sp,
                      fontWeight: fontWeight,
                    ),
                  ),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: iconColor, size: iconSize),
                  SizedBox(width: spacing.w),
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor,
                      fontSize: fontSize.sp,
                      fontWeight: fontWeight,
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
