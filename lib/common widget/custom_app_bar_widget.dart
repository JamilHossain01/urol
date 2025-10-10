import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final bool showLeadingIcon;

  const CustomAppBar({
    Key? key,
    this.title,
    this.onTap,
    this.backgroundColor = Colors.transparent,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.showLeadingIcon = true,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false, // 👈 prevents default back icon
      leading: showLeadingIcon
          ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 32.h,
          width: 32.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.r),
            color: Colors.white,
          ),
          child: leading ??
              IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    color: Colors.black, size: 18),
                onPressed: onTap ?? () => Navigator.pop(context),
              ),
        ),
      )
          : null,
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      centerTitle: centerTitle,
      actions: actions,
    );
  }
}
