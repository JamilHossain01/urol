import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarWithFilter extends StatelessWidget {
  final VoidCallback onFilterTap;
  final Color? backgroundColor;
  final ValueChanged<String>? onSearchChanged; // 👈 Callback for search text

  const SearchBarWithFilter({
    Key? key,
    required this.onFilterTap,
    this.backgroundColor,
    this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: "Search location here...",
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFFB9B9B9),
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color(0xFFB9B9B9),
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),

        // ⚙️ Filter Button
        InkWell(
          onTap: onFilterTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: 44.h,
            width: 50.h,
            decoration: BoxDecoration(
              color: const Color(0xFFA32020),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
