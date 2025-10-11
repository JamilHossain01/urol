
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Custom Container Widget
class CustomContainer extends StatelessWidget {
  final Color? color;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final BoxShadow? boxShadow;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final AlignmentGeometry? alignment;
  final GestureTapCallback? onTap;

  const CustomContainer({
    Key? key,
    this.color,
    this.height,
    this.width,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.padding,
    this.child,
    this.alignment,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 100.h,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: color ?? Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 1.0, // Default border width
          ),
          boxShadow: boxShadow != null
              ? [boxShadow!] // Only add shadow if it's provided
              : [],
        ),
        padding: padding ?? EdgeInsets.all(10.w), // Default padding inside container
        alignment: alignment ?? Alignment.center, // Default alignment is center
        child: child, // The child widget that will be inside the container
      ),
    );
  }
}
