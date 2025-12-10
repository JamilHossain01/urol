import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_button_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/app_images.dart';
import '../edite_profeil_view.dart';

class UserInfoCard extends StatefulWidget {
  final String homeGym;
  final dynamic height;
  final String weight;
  final List<String> skills;
  final String favoriteQuote;

  const UserInfoCard({
    super.key,
    required this.homeGym,
    required this.height,
    required this.weight,
    required this.skills,
    required this.favoriteQuote,
  });

  @override
  State<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends State<UserInfoCard> {
  bool isExpanded = false; // For See more / See less

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🏠 Home Gym Section
          Row(
            children: [
              Container(
                height: 38.h,
                width: 38.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF989898),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    AppImages.location,
                    height: 18.h,
                    width: 15.w,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Home Gym",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.pTextColors,
                  ),
                  CustomText(
                    text: widget.homeGym,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 10.h),

          /// 📏 Height and Weight Row
          Row(
            children: [
              _infoTile(AppImages.scale, "Height", "${widget.height}"),
              Gap(10.w),
              _infoTile(AppImages.kg, "Weight", "${widget.weight} lb"),
            ],
          ),

          SizedBox(height: 10.h),

          /// 🎯 Skills Section
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: [
              for (var skill in widget.skills) _skillChip(skill),
            ],
          ),

          Divider(
            color: const Color(0xFF000000).withOpacity(0.10),
          ),
          SizedBox(height: 4.h),

          /// 🧠 Favorite Quote
          CustomText(
            text: "Favorite Quote",
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4B4B4B),
          ),
          SizedBox(height: 10.h),

          /// QUOTE + SEE MORE / SEE LESS
          LayoutBuilder(
            builder: (context, constraints) {
              final span = TextSpan(
                text: "“${widget.favoriteQuote}”",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              );

              final tp = TextPainter(
                text: span,
                maxLines: 2,
                textDirection: TextDirection.ltr,
              );

              tp.layout(maxWidth: constraints.maxWidth);

              bool isOverflowing = tp.didExceedMaxLines;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "“${widget.favoriteQuote}”",
                    maxLines: isExpanded ? null : 2,
                    overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),

                  if (isOverflowing)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 6.h),
                        child: Text(
                          isExpanded ? "See less" : "See more",
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          SizedBox(height: 8.h),

          /// ✏️ Edit Button
          CustomButtonWidget(
            btnText: 'Edit',
            onTap: () {
              Get.to(() => const EditProfileView());
            },
            iconWant: false,
            btnColor: Colors.white,
            btnTextColor: AppColors.mainColor,
            borderColor: AppColors.mainColor,
          ),
        ],
      ),
    );
  }

  /// 🔹 Info Tile for Height / Weight
  Widget _infoTile(String iconPath, String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, height: 20.h, width: 20.w),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: label,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.pTextColors,
                ),
                CustomText(
                  text: value,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 🔹 Skill Chip Widget
  Widget _skillChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.mainColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: CustomText(
        text: text,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.mainColor,
      ),
    );
  }
}
