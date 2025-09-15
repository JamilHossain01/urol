// text_styles.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyles {
  static TextStyle dynamicStyle({
    required double fontSize,
    required FontWeight fontWeight,
    Color? color,
  }) {
    return GoogleFonts.kumbhSans(
      fontSize: fontSize.h,
      fontWeight: fontWeight,
      color: color ?? Colors.black,
    );
  }


}




class AppStyles {
  static  LinearGradient appBarGradient = LinearGradient(
    begin: Alignment.topLeft,
    colors: [
      AppColors.bgColor,
      Color(0xFF302B63),
      AppColors.bgColor,
    ],
  );
}
