import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import 'notification_widgets.dart';
// Assuming NotificationBell widget is here

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "uJitsu",
              style: GoogleFonts.pacifico(
                fontSize: 21.h,
                color: AppColors.mainColor,
              ),
            )
          ],
        ),
        NotificationBell(notificationCount: 5),
      ],
    );
  }
}
