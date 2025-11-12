import 'package:calebshirthum/view/user/profile_view/save_gyms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Add the cached network image package
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_button_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../../../uitilies/app_images.dart';
import '../../../common widget/comon_conatainer/custom_conatiner.dart';
import '../location_view/claim_your_gym.dart';

// Add the cached network image package
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; // Add Smooth Page Indicator

class SaveGymDetailsScreen extends StatefulWidget {
  const SaveGymDetailsScreen({super.key});

  @override
  State<SaveGymDetailsScreen> createState() => _SaveGymDetailsScreenState();
}

class _SaveGymDetailsScreenState extends State<SaveGymDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gym Cover Image (Using PageView for swipeable images)
            Stack(
              children: [
                Container(
                  height: 220.h,
                  width: double.infinity,
                  child: PageView(
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    children: [
                      // CachedNetworkImage for gym images
                      _buildGymImage('https://example.com/gym_image_1.jpg'),
                      _buildGymImage('https://example.com/gym_image_2.jpg'),
                      _buildGymImage(AppImages.gym2), // fallback to AssetImage
                    ],
                  ),
                ),
                Positioned(
                  top: 40.h,
                  left: 16.w,
                  child: GestureDetector(
                    onTap: Get.back,
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black54,
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40.h,
                  right: 16.w,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => SaveGymsView());
                    },
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black54,
                      child: Center(
                        child: Icon(
                          Icons.bookmark_border,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Circular Indicator for page progress
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: SmoothPageIndicator(
                  controller:
                      _pageController, // PageController to control the indicator
                  count: 3, // Total number of images
                  effect: ExpandingDotsEffect(
                    dotWidth: 8.w,
                    dotHeight: 8.h,
                    spacing: 6.w,
                    activeDotColor: AppColors.mainColor, // Active dot color
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Gym Name
                  CustomText(
                    text: "GymNation Stars",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainTextColors,
                  ),
                  Gap(5.h),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: Color(0xFF4B4B4B), size: 16),
                      Gap(5.w),
                      CustomText(
                        text: "6157 Rd, California, USA",
                        fontSize: 10.sp,
                        color: Color(0xFF4B4B4B),
                      ),
                    ],
                  ),
                  Gap(10.h),

                  // Tags
                  Wrap(
                    spacing: 8.w,
                    children: [
                      _buildChip("Open Mat"),
                      _buildChip("NO-GI"),
                      _buildChip("Brazilian Jiu-Jitsu"),
                    ],
                  ),
                  Gap(15.h),

                  // Description
                  CustomText(
                    maxLines: 10,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.w400,
                    text:
                        "GymNation Stars gives a full view of the gym’s offerings, schedule, and amenities. At the top, users see the gym name, logo, star rating, and location linked to an interactive map. A brief overview highlights services, atmosphere, and training types, with a photo gallery for a visual tour.",
                    fontSize: 12.sp,
                    color: Color(0xFF686868),
                  ),

                  // Info Section

                  Gap(10.h),
                  CustomContainer(
                    color: Color(0xFFF8F9FA),
                    borderColor: Color(0xFF989898),
                    height: 150.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Contact Information",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.mainTextColors,
                        ),
                        Gap(5.h),
                        _buildInfoRow(
                            AppImages.call, "(580) 559-7890", "Phone"),
                        Divider(),
                        _buildInfoRow(
                            AppImages.teligram, "info@gymnation.com", "Email"),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.earth2,
                                  height: 18.h,
                                  width: 18.w,
                                ),
                                SizedBox(width: 10.w),
                                CustomText(
                                  text: "Social",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  color: AppColors.mainTextColors,
                                ),
                              ],
                            ),
                            CustomText(
                              text: "Visit Website",
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Color(0xFF989898),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Gap(20.h),

                  // Schedule
                  CustomText(
                    text: "Open Mat Schedule",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainTextColors,
                  ),
                  Gap(10.h),
                  _buildSchedule("9:00 - 11:00 PM", "Sun - Tue", "Open Mat"),
                  _buildSchedule("4:00 - 6:00 PM", "Wed, Thu", "Open Mat"),
                  _buildSchedule("9:00 - 11:00 PM", "Sun, Mon", "Open Mat"),
                  _buildSchedule("4:00 - 6:00 PM", "Tue, Wed", "Open Mat"),
                  Gap(10.h),
                  CustomText(
                    text: "Class Schedule",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mainTextColors,
                  ),
                  Gap(10.h),
                  _buildSchedule(
                      "9:00 - 11:00 PM", "Monday", "BJJ Fundamentals"),
                  _buildSchedule(
                      "4:00 - 6:00 PM", "Tuesday", "Muay Thai Kickboxing"),
                  _buildSchedule("9:00 - 11:00 PM", "Thursday", "Advanced BJJ"),
                  Gap(10.h),

                  CustomButtonWidget(
                    btnText: 'Claim This Gym',
                    onTap: () {
                      Get.to(() => ClaimYourGymScreen(
                            gymId: '',
                          ));
                    },
                    iconWant: false,
                    btnColor: AppColors.mainColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: CustomText(
        text: text,
        fontSize: 12.sp,
        color: Colors.white,
      ),
    );
  }

  Widget _buildInfoRow(String iconPath, String text1, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                iconPath,
                height: 18.h,
                width: 18.w,
              ),
              SizedBox(width: 10.w),
              CustomText(
                text: text,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
                color: AppColors.mainTextColors,
              ),
            ],
          ),
          CustomText(
            text: text1,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: const Color(0xFF989898),
          ),
        ],
      ),
    );
  }

  Widget _buildSchedule(
    String time,
    String days,
    String name,
  ) {
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: AppColors.mainColor),
                  Gap(5.w),
                  CustomText(
                    text: "$time",
                    fontSize: 10.sp,
                    color: Color(0xFF686868),
                  ),
                ],
              ),
              Gap(10.w),
              CustomText(
                text: "$days",
                fontSize: 10.sp,
                color: Color(0xFF686868),
              ),
            ],
          ),
          CustomText(
            text: name,
            fontSize: 16.sp,
            color: AppColors.mainTextColors,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }

  // Helper method to build CachedNetworkImage or fallback to AssetImage if URL fails
  Widget _buildGymImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl, // URL of the gym image
      height: 220.h,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          Center(child: CircularProgressIndicator()), // Loading state
      errorWidget: (context, url, error) => Image.asset(AppImages.gym2,
          fit: BoxFit.cover), // Fallback to AssetImage
    );
  }
}
