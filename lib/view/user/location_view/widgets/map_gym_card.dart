import 'package:cached_network_image/cached_network_image.dart';
import 'package:calebshirthum/common%20widget/custom_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/custom_loader.dart';

class MapGymView extends StatelessWidget {
  final String image, gymName, location;
  final List<String> categories;
  final bool showDelete;
  final bool showEdit;
  final String? gymId;
  final VoidCallback? delete;
  final VoidCallback? editTap;
  final VoidCallback? viewDetails;

  final bool? centerGymName;
  final BoxFit? imageFit;

  const MapGymView({
    Key? key,
    required this.image,
    required this.gymName,
    required this.location,
    required this.categories,
    this.delete,
    required this.showDelete,
    required this.showEdit,
    this.gymId,
    this.editTap,
    this.centerGymName,
    this.imageFit,
    this.viewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE + GYM NAME ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: image,
                  height: 105.h,
                  width: 105.w, // fixed width
                  fit: imageFit ?? BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 30.h,
                      width: 30.h,
                      child: CustomLoader(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: const Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              ),
              Gap(8.w),
              // Gym name + optional buttons
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomText(
                            textAlign: TextAlign.start,
                            text: gymName,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainTextColors,
                          ),
                        ),
                        InkWell(
                          onTap: delete,
                          child: Icon(
                            Icons.remove_circle_outline,
                            color: AppColors.mainColor,
                            size: 25.sp,
                          ),
                        ),
                      ],
                    ),
                    Gap(4.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/location.png",
                          height: 12.h,
                          width: 12.w,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            location,
                            style: TextStyle(
                              letterSpacing: 0,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF4B4B4B),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 4.h,
                      children: categories
                          .map((category) => _buildChip(category))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Gap(14.h),

          SizedBox(
            height: 35.h,
            child: CustomButtonWidget(
              btnTextSize: 16.0,
              btnText: "View Details",
              onTap: viewDetails!,
              iconWant: false,
              btnColor: AppColors.mainColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: CustomText(
        text: text,
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }
}
