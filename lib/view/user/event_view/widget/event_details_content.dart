import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/shimmer/full_image_view_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:calebshirthum/common widget/custom text/custom_text_widget.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../uitilies/custom_toast.dart';

class EventDetailsContent extends StatelessWidget {
  final String imageUrl;
  final String location;
  final String eventType;
  final String registrationFee;
  final String day;
  final String staus;
  final String link;

  const EventDetailsContent({
    super.key,
    required this.imageUrl,
    required this.location,
    required this.eventType,
    required this.registrationFee,
    required this.link,
    required this.day,
    required this.staus,
  });

  Future<void> _launchUrl(String link) async {
    final Uri _url = Uri.parse(link);

    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      CustomToast.showToast(
        "Could not launch the link",
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: GestureDetector(
              onTap: () {
                Get.to(() => FullImageView(imageUrls: [imageUrl]));
              },
              child: Image.network(
                imageUrl,
                height: 140.h,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;

                  return Container(
                    height: 140.h,
                    width: double.infinity,
                    color: Colors.grey.shade200,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation(AppColors.mainColor),
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 140.h,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                    child: Icon(
                      Icons.broken_image,
                      size: 40.sp,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            )),

        SizedBox(height: 20.h),

        // Location + Icon
        Row(
          children: [
            Icon(Icons.location_on, color: AppColors.mainColor, size: 22.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: CustomText(
                text: location,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),

        SizedBox(height: 18.h),

        // Event Info Cards
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _infoCard(
              icon: Icons.event,
              title: "Event Type",
              value: eventType,
            ),
            _infoCard(
              icon: Icons.attach_money,
              title: "Reg. Fee",
              value: registrationFee,
            ),
          ],
        ),

        SizedBox(
          height: 10.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _infoCard(
              icon: Icons.data_exploration_outlined,
              title: "Days Left",
              value: day,
            ),
            _infoCard(
              icon: Icons.access_alarm,
              title: "Status",
              value: staus,
            ),
          ],
        ),

        SizedBox(height: 20.h),

        // Description
        CustomText(
          text: "Registration Fee Link",
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 8.h),

        GestureDetector(
          onTap: () {
            _launchUrl(link);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
            decoration: BoxDecoration(
              color: AppColors.mainColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.mainColor, width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.link, color: AppColors.mainColor, size: 20.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    link,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 20.h),

        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 26.sp, color: AppColors.mainColor),
            SizedBox(height: 10.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.h),
            CustomText(
              text: value,
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}
