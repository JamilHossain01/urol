import 'package:calebshirthum/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:calebshirthum/common%20widget/custom_elipse_text.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:calebshirthum/view/user/location_view/controller/add_booksmarks_controller.dart';
import 'package:calebshirthum/view/user/location_view/controller/gym_details_controller.dart';
import 'package:calebshirthum/view/user/location_view/widgets/build_info_widget.dart';
import 'package:calebshirthum/view/user/location_view/widgets/build_schdule_widget.dart';
import 'package:calebshirthum/view/user/profile_view/save_gyms.dart';
import 'package:calebshirthum/view/user/location_view/claim_your_gym.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common widget/comon_conatainer/custom_conatiner.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../uitilies/custom_loader.dart';
import '../../../uitilies/custom_toast.dart';
import '../profile_view/widgets/shimmer/full_image_view_shimmer.dart';

class GymDetailsScreen extends StatefulWidget {
  final String gymId;

  const GymDetailsScreen({super.key, required this.gymId});

  @override
  State<GymDetailsScreen> createState() => _GymDetailsScreenState();
}

class _GymDetailsScreenState extends State<GymDetailsScreen> {
  final PageController _pageController = PageController();
  final GetGymDetailsController _getGymDetailsController =
      Get.put(GetGymDetailsController());

  final AddGymBookMarksController _addGymBookMarksController =
      Get.put(AddGymBookMarksController());

  @override
  void initState() {
    super.initState();
    _getGymDetailsController.getGymDetails(
      gymId: widget.gymId,
    );
  }

  String _shortenLink(String link) {
    if (link.length > 25) {
      return '${link.substring(0, 20)}...';
    }
    return link;
  }

  Future<void> _launchUrl(String link) async {
    final Uri _url = Uri.parse(link);

    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      CustomToast.showToast("Could not launch the link", isError: true);
    }
  }

  Future<void> _phoneCall(String num) async {
    final Uri _url = Uri.parse("tel:$num");

    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (_getGymDetailsController.isLoading.value) {
          return Center(child: CustomLoader());
        }

        final data = _getGymDetailsController.allEvent.value.data;
        if (data == null) {
          return const Center(child: Text("No data available"));
        }

        final bool hasAnySocial =
            (data.website != null && data.website!.isNotEmpty) ||
                (data.facebook != null && data.facebook!.isNotEmpty) ||
                (data.instagram != null && data.instagram!.isNotEmpty);

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- IMAGES ------------
              Stack(
                children: [
                  SizedBox(
                    height: 225.h,
                    width: double.infinity,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount:
                          data.images.isNotEmpty ? data.images.length : 1,
                      itemBuilder: (context, index) {
                        if (data.images.isEmpty) {
                          return Image.asset(AppImages.gym2, fit: BoxFit.cover);
                        }
                        return GestureDetector(
                          onTap: () {
                            Get.to(() => FullImageView(
                                  imageUrls: data.images
                                      .map((e) => e.url ?? '')
                                      .toList(),
                                  initialIndex: index,
                                ));
                          },
                          child: _buildGymImage(data.images[index].url ?? ''),
                        );
                      },
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
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40.h,
                    right: 16.w,
                    child: GestureDetector(
                      onTap: () {
                        _addGymBookMarksController.addGym(gymId: data.id);
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black54,
                        child: data.isSaved == true
                            ? Icon(Icons.bookmark, color: Colors.white)
                            : Icon(Icons.bookmark_add_outlined,
                                color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              // ---------- PAGE INDICATOR ------------
              if (data.images.isNotEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: data.images.length,
                      effect: ExpandingDotsEffect(
                        dotWidth: 8.w,
                        dotHeight: 8.h,
                        spacing: 6.w,
                        activeDotColor: AppColors.mainColor,
                      ),
                    ),
                  ),
                ),

              // ---------- DETAILS SECTION ------------
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    CustomText(
                      text: data.name ?? 'No Name',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.mainTextColors,
                    ),
                    Gap(5.h),

                    // Location
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: Color(0xFF4B4B4B), size: 16),
                        Gap(5.w),
                        CustomText(
                          text: customEllipsisText(
                              "${data.street ?? ''}",
                              wordLimit: 11),
                          fontSize: 10.sp,
                          color: const Color(0xFF4B4B4B),
                        ),
                      ],
                    ),
                    Gap(10.h),

                    if ((data.apartment ?? '').isNotEmpty)
                      Row(
                        children: [
                          const Icon(
                            Icons.business,
                            color: Color(0xFF4B4B4B),
                            size: 16,
                          ),
                          Gap(5.w),
                          CustomText(
                            text: customEllipsisText(
                              "Suite: ${data.apartment}",
                              wordLimit: 9,
                            ),
                            fontSize: 10.sp,
                            color: const Color(0xFF4B4B4B),
                          ),
                        ],
                      ),

                    Gap(5.h),

                    // Tags
                    if (data.disciplines.isNotEmpty)
                      Wrap(
                        spacing: 8.w,
                        children:
                            data.disciplines.map((e) => _buildChip(e)).toList(),
                      ),

                    Gap(10.h),

                    // Description
                    CustomText(
                      maxLines: 10,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w400,
                      text: data.description ?? 'No description available.',
                      fontSize: 12.sp,
                      color: const Color(0xFF686868),
                    ),

                    Gap(10.h),

                    // ---------- INFO CONTAINER ------------
                    CustomContainer(
                      color: const Color(0xFFF8F9FA),
                      borderColor: const Color(0xFF989898),
                      height: 155.h,
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
                          BuildInfoWidget(
                            tap: () => _phoneCall(data.phone ?? ''),
                            iconPath: AppImages.call,
                            text: "Phone",
                            text1: data.phone ?? 'N/A',
                          ),
                          const Divider(),
                          BuildInfoWidget(
                            tap: () {
                              if (data.website != null &&
                                  data.website!.isNotEmpty) {
                                _launchUrl(data.website!);
                              }
                            },
                            iconPath: AppImages.earth2,
                            text: "Website",
                            text1:
                                (data.website == null || data.website!.isEmpty)
                                    ? 'N/A'
                                    : _shortenLink(data.website!),
                          ),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// Left side title
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

                              if (hasAnySocial)
                                Row(
                                  children: [
                                    if (data.website != null &&
                                        data.website!.isNotEmpty)
                                      GestureDetector(
                                        onTap: () => _launchUrl(data.website!),
                                        child: Image.asset(
                                          AppImages.https,
                                          height: 18.h,
                                          width: 18.w,
                                        ),
                                      ),
                                    if (data.website != null &&
                                        data.website!.isNotEmpty)
                                      Gap(5.w),
                                    if (data.facebook != null &&
                                        data.facebook!.isNotEmpty)
                                      GestureDetector(
                                        onTap: () => _launchUrl(data.facebook!),
                                        child: Image.asset(
                                          AppImages.fb,
                                          height: 18.h,
                                          width: 18.w,
                                        ),
                                      ),
                                    if (data.facebook != null &&
                                        data.facebook!.isNotEmpty)
                                      Gap(5.w),
                                    if (data.instagram != null &&
                                        data.instagram!.isNotEmpty)
                                      GestureDetector(
                                        onTap: () =>
                                            _launchUrl(data.instagram!),
                                        child: Image.asset(
                                          AppImages.insta,
                                          height: 18.h,
                                          width: 18.w,
                                        ),
                                      ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Gap(20.h),

                    // ---------- MAT SCHEDULE ------------
                    if (data.matSchedules.isNotEmpty) ...[
                      CustomText(
                        text: "Open Mat Schedule",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainTextColors,
                      ),
                      Gap(10.h),
                      Column(
                        children: data.matSchedules.map((s) {
                          return BuildScheduleWidget(
                            days: s.day ?? '',
                            time: "${s.fromView ?? ''} - ${s.toView ?? ''}",
                            name: 'Open Mat Session',
                          );
                        }).toList(),
                      ),
                    ],

                    Gap(10.h),

                    // ---------- C SCHEDULE ------------
                    if (data.classSchedules.isNotEmpty) ...[
                      CustomText(
                        text: "Class Schedule",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainTextColors,
                      ),
                      Gap(10.h),
                      Column(
                        children: data.classSchedules.map((s) {
                          return BuildScheduleWidget(
                            days: s.day ?? '',
                            time: "${s.fromView ?? ''} - ${s.toView ?? ''}",
                            name: s.name?.toString() ?? "Class Session",
                          );
                        }).toList(),
                      ),
                    ],

                    Gap(20.h),

                    // ---------- CLAIM BUTTON ------------

                    if (data.isClaimed == false)
                      CustomButtonWidget(
                        btnText: 'Claim This Gym',
                        onTap: () => Get.to(() => ClaimYourGymScreen(
                              gymId: _getGymDetailsController
                                  .allEvent.value.data?.id.toString() ?? "",
                            )),
                        iconWant: false,
                        btnColor: AppColors.mainColor,
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // ---------- CHIPS ----------
  Widget _buildChip(String text) {
    return Padding(
        padding: REdgeInsets.fromLTRB(0, 4, 0, 0),
        child: Container(
          padding: EdgeInsets.all(6.h),
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: CustomText(
            text: text,
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ));
  }

  // ---------- IMAGE ----------
  Widget _buildGymImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: 250.h,
      width: double.infinity,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(child: CustomLoader()),
      errorWidget: (context, url, error) =>
          Image.asset(AppImages.gym2, fit: BoxFit.fill),
    );
  }
}
