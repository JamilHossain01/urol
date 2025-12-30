import 'package:calebshirthum/common%20widget/custom_app_bar_widget.dart';
import 'package:calebshirthum/common%20widget/custom_button_widget.dart';
import 'package:calebshirthum/common%20widget/custom_date_format.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/profille_header_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import 'controller/add_friend_controller.dart';
import 'controller/unfriend_controller.dart';

class FindProfileView extends StatelessWidget {
  final String? follow;
  final String firstName;
  final String friendId;
  final String lastName;
  final String quote;
  final String gymName;
  final String imageUrl;
  final String beltRank;
  final List<String> disciplines;
  final String height;
  final String weight;
  final String? eventDate;
  final String? eventLocation;
  final String? eventDivision;
  final String? eventBadge;
  final String? eventName;
  final dynamic eventStatus;
  final bool statusOfFollow;

  FindProfileView({
    super.key,
    this.follow,
    required this.firstName,
    required this.lastName,
    required this.quote,
    required this.gymName,
    required this.imageUrl,
    required this.beltRank,
    required this.disciplines,
    required this.height,
    required this.weight,
    this.eventDate,
    this.eventLocation,
    this.eventDivision,
    this.eventBadge,
    this.eventName,
    this.eventStatus,
    required this.statusOfFollow,
    required this.friendId,
  });

  final AddFriendController addFriendController =
      Get.put(AddFriendController());

  final UnfriendController _unfriendController = Get.put(UnfriendController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            children: [
              ProfileHeaderWithBelt(
                imageUrl: imageUrl,
                name: "$firstName $lastName",
                beltRank: beltRank,
              ),

              SizedBox(height: 20.h),

              // Profile Info Section
              _buildProfileInfo(),

              SizedBox(height: 20.h),

              if (eventStatus != null) _buildEventSection(),

              Obx(() {
                return addFriendController.isLoading.value == true || _unfriendController.isLoading.value
                    ? CustomLoader()
                    : Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        child: CustomButtonWidget(
                          btnText:
                              statusOfFollow == true ? "Follow" : "Unfollow",
                          onTap: () {
                            statusOfFollow == true
                                ? addFriendController.addFriend(id: friendId)
                                : _unfriendController.unFriend(id: friendId);
                          },
                          iconWant: false,
                          btnColor: Colors.white,
                          btnTextColor: AppColors.mainColor,
                          borderColor: AppColors.mainColor,
                        ),
                      );
              })
            ],
          ),
        ),
      ),
    );
  }

  /// 🧩 Profile Info Section
  Widget _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gym Info
          Row(
            children: [
              _iconContainer(AppImages.location),
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
                    text: gymName,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Height & Weight
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _infoTile(AppImages.scale, "Height", height),
              _infoTile(AppImages.kg, "Weight", "$weight lb"),
            ],
          ),

          SizedBox(height: 16.h),

          // Disciplines
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: disciplines.map((d) => _skillChip(d)).toList(),
          ),

          SizedBox(height: 16.h),

          // Favorite Quote
          CustomText(
            text: "Favorite Quote",
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF4B4B4B),
          ),
          SizedBox(height: 4.h),
          CustomText(
            maxLines: 2,
            textAlign: TextAlign.start,
            text: "“$quote”",
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ],
      ),
    );
  }

  /// 🏆 Event Section
  Widget _buildEventSection() {
    Widget _buildMedalIcon(String? result) {
      if (result == "Gold") {
        return Image.asset(
          "assets/images/goldOne.png",
          height: 26,
          width: 26,
        );
      } else if (result == "Silver") {
        return Image.asset(
          "assets/images/silverTwo.png",
          height: 26,
          width: 26,
        );
      } else if (result == "Bronze") {
        return Image.asset(
          "assets/images/bronzeThree.png",
          height: 26,
          width: 26,
        );
      } else if (result == "DNP") {
        return Image.asset(
          "assets/images/dnp.png",
          height: 26,
          width: 26,
        );
      }

      return Container();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Row(
            children: [
              Image.asset(AppImages.cup, height: 14.h, width: 14.w),
              SizedBox(width: 5.w),
              CustomText(
                text: "Recent Event Results",
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Event Card
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12.r),
              color: Colors.grey.shade100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: eventName ?? "",
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Image.asset(AppImages.calender, height: 14.h, width: 14.w),
                    SizedBox(width: 5.w),
                    CustomText(
                      text: eventDate != null
                          ? CustomDateFormatter.formatDate(eventDate!)
                          : "N/A",
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF686868),
                    ),
                  ],
                ),
                const Divider(),

                // Division & Location
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _eventInfo(
                        "Division", eventDivision ?? "N/A", AppImages.division),
                    _eventInfo(
                        "Location", eventLocation ?? "N/A", AppImages.location),
                  ],
                ),

                SizedBox(height: 12.h),

                // Badge
                if (eventBadge != null && eventBadge!.isNotEmpty)
                  Center(
                    child: Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6E6E6),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildMedalIcon(eventBadge),
                          SizedBox(width: 8.w),
                          CustomText(
                            text: eventBadge!,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.orangeColor,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String icon, String title, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(icon, height: 14.h, width: 14.w),
              SizedBox(width: 6.w),
              CustomText(
                text: title,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            ],
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: value,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ],
      );

  Widget _skillChip(String text) => Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: CustomText(
          text: text,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      );

  Widget _eventInfo(String title, String value, String icon) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(icon, height: 14.h, width: 14.w),
              SizedBox(width: 6.w),
              CustomText(
                text: title,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade600,
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE9E9E9),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: CustomText(
              text: value,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF686868),
            ),
          ),
        ],
      );

  Widget _iconContainer(String asset) => Container(
        height: 38.h,
        width: 38.w,
        decoration: BoxDecoration(
          color: const Color(0xFF989898),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            asset,
            color: Colors.white,
          ),
        ),
      );
}
