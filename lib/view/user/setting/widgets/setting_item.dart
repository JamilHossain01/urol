import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';



class SettingItem extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingItem({
    super.key,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomText(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        textAlign: TextAlign.start,
        text: title,
        color: AppColors.mainTextColors,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}