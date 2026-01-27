import 'package:cached_network_image/cached_network_image.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/common widget/custom text/custom_text_widget.dart';
import 'package:calebshirthum/view/user/home_view/widgets/shimmer/shimmer_card_of_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class MatCardData {
  final String name;
  final String distance;
  final String days;
  final String time;
  final String image;
  final VoidCallback onTap;

  MatCardData({
    required this.name,
    required this.distance,
    required this.days,
    required this.time,
    required this.image,
    required this.onTap,
  });
}

class NearbyMatsSection extends StatefulWidget {
  final List<MatCardData> mats;

  const NearbyMatsSection({super.key, required this.mats});

  @override
  State<NearbyMatsSection> createState() => _NearbyMatsSectionState();
}

class _NearbyMatsSectionState extends State<NearbyMatsSection> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  void _simulateLoading() async {
    await Future.delayed(Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: widget.mats
              .map(
                (mat) => GestureDetector(
                  onTap: mat.onTap,
                  child: _buildNearbyMatCard(
                    mat.name,
                    mat.distance,
                    mat.days,
                    mat.time,
                    mat.image,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  Widget _buildNearbyMatCard(
      String name, String distance, String days, String time, String image) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  imageUrl: image,
                  height: 70.h,
                  width: 90.w,
                  fit: BoxFit.cover,
                )),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        color: AppColors.mainTextColors,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.h,
                        text: name,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(10.r)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: CustomText(
                            color: const Color(0xFF686868),
                            fontSize: 10.h,
                            text: "$distance mi",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(5.h),
                  // Days
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: CustomText(
                        color: const Color(0xFF686868),
                        fontSize: 10.h,
                        text: days,
                      ),
                    ),
                  ),
                  Gap(5.h),
                  // Time Row
                  Row(
                    children: [
                      const Icon(Icons.access_time,
                          size: 12, color: Colors.grey),
                      Gap(4.w),
                      CustomText(
                        color: const Color(0xFF686868),
                        fontSize: 12.h,
                        text: time,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerWidget.rectangular({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}
