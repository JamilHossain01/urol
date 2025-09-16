import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SearchAndFilterRow extends StatelessWidget {
  final VoidCallback onFilterTap;

  const SearchAndFilterRow({Key? key, required this.onFilterTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search here...",
              hintStyle: TextStyle(fontSize: 14.sp, color: Color(0xFFB9B9B9)),
              prefixIcon: const Icon(Icons.search, color: Color(0xFFB9B9B9)),
              contentPadding: EdgeInsets.symmetric(vertical: 10.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Color(0xFFB9B9B9)),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          ),
        ),
        Gap(10.w),
        InkWell(
          onTap: onFilterTap,
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.red.shade700,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.filter_alt, color: Colors.white, size: 20.h),
          ),
        ),
      ],
    );
  }
}
