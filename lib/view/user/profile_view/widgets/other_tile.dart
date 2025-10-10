import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/comon_conatainer/custom_conatiner.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';

class OtherTile extends StatelessWidget {
  final String text;
  final Color? textColor;
  final String iconPath;
  final VoidCallback onTap;

  const OtherTile({
    Key? key,
    required this.text,
    required this.iconPath,
    required this.onTap,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: CustomContainer(
        color: const Color(0xFFE9E9E9),
        borderRadius: 8,
        height: 55.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(width: 12.w),
                Image.asset(
                  iconPath,
                  height: 18.h,
                  width: 18.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 10.w),
                CustomText(
                  text: text,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? Colors.black,
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Icon(
                Icons.chevron_right,
                size: 20.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
