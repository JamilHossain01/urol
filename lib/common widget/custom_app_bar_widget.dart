import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../uitilies/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double? fontSize;
  final VoidCallback? onTap;
  final bool centerTitle;
  final bool forceMaterialTransparency;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showLeadingIcon;

  const CustomAppBar({
    Key? key,
    this.title,
    this.fontSize,
    this.centerTitle = true,
    this.forceMaterialTransparency = true,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.onTap,
    this.showLeadingIcon = true,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Text(
        title ?? "",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: fontSize ?? 17.h,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
      leading: showLeadingIcon
          ? Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xFF000000).withOpacity(0.02), // Shadow color
              offset: Offset(2, 2), // Offset of the shadow
              blurRadius: 5, // Blur intensity
              spreadRadius: 1, // Spread of the shadow
            ),
          ],
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: leading ??
            IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: onTap ??
                      () {
                    if (Get.isSnackbarOpen) {
                      Get.closeCurrentSnackbar();
                    }
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    } else {
                      if (kDebugMode) {
                        print("No routes to pop");
                      }
                    }
                  },
            ),
      )
          : null,
      elevation: forceMaterialTransparency ? 0 : null,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
