import 'package:calebshirthum/common%20widget/custom_button_widget.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/profille_header_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../common widget/custom text/custom_text_widget.dart';
import 'add_compition_view.dart';
import 'edite_profeil_view.dart';

class FindProfileView extends StatelessWidget {
  final String ? follow;
  const FindProfileView({super.key, this.follow});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),

              // Profile Image + Belt
              ProfileHeaderWithBelt(
                imageUrl: AppImages.person, // Replace with your image URL or asset
                name: 'Caleb Shirtum',
              ),


              SizedBox(height: 20.h),

              // Home Gym Section
              Container(
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
                    Row(
                      children: [
                        Container(
                          height: 38.h,
                          width: 38.w,
                          decoration: BoxDecoration(
                            color: Color(0xFF989898),
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
                              text: "The Arena Combat Academy",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _infoTile(AppImages.scale, "Height", "5'10\""),
                        _infoTile(AppImages.kg, "Weight", "170 lb"),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 6.h,
                      children: [
                        _skillChip("Jiu Jitsu"),
                        _skillChip("Wrestling"),
                        _skillChip("Judo"),
                        _skillChip("MMA"),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    CustomText(
                      text:
                      "Favorite Quote",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4B4B4B),
                    ), CustomText(
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      text:
                      "“Discipline is the bridge between goals and accomplishments.”",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                    SizedBox(height: 8.h),

                  ],
                ),
              ),

              SizedBox(height: 20.h),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(

                      children: [
                        SizedBox(child: Image.asset(AppImages.cup,height: 14.h,width: 14.w,),),
                        SizedBox(width: 5.w,),
                        CustomText(
                          text: "Recent Event Results",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              // Recent Event Results
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          CustomText(
                            text: "IBJJF World Championships 2024",
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          SizedBox(height: 4.h),

                          Row(

                            children: [
                              SizedBox(child: Image.asset(AppImages.calender,height: 14.h,width: 14.w,),),
                              SizedBox(width: 5.w,),
                              CustomText(
                                text: "March 15, 2025",
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF686868),
                              ),
                            ],
                          ),
                          Divider(),

                          // SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _eventInfo("Division", "NoGi Absolute",
                                  AppImages.division),
                              _eventInfo("Location", "Buffalo, New York",
                                  AppImages.Location),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Center(
                            child: Column(
                              children: [
                                SizedBox(height: 8.h),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE6E6E6),
                                    borderRadius: BorderRadius.circular(6.r),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          AppImages.badge,
                                          height: 20.h,
                                          width: 20.w,
                                        ),
                                        CustomText(
                                          color: AppColors.orangeColor,
                                          fontSize: 14.h,
                                          fontWeight: FontWeight.w600,
                                          text: "GOLD",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(height: 8.h),

                                Divider(),
                                GestureDetector(
                                  onTap: (){
                                    Get.to(()=> AddCompetitionResultScreen());
                                  },
                                  child: CustomText(
                                    text: "Add Competition Result",
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color:AppColors.mainColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),


              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButtonWidget(
                  btnText: follow ?? "Follow",
                  onTap: () {
                    Get.to(() => EditProfileView());
                    // Get.to(() => EditGymDetailsScreen());
                  },
                  iconWant: false,
                  btnColor: Colors.white,
                  btnTextColor: AppColors.mainColor,
                  borderColor: AppColors.mainColor,
                ),
              ),
              SizedBox(height: 10.h),


            ],
          ),
        ),
      ),
    );
  }

  // ✅ Info Tile (Height, Weight)
// ✅ Info Tile (with asset image icon)
  Widget _infoTile(String iconPath, String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              iconPath,
              height: 14.h,
              width: 14.w,
              fit: BoxFit.contain,
            ),
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
  }

  // ✅ Skill Chip
  Widget _skillChip(String text) {
    return Container(
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
  }

  // ✅ Event Info
// ✅ Event Info (with asset icon)
  Widget _eventInfo(String title, String value, String iconPath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              iconPath,
              height: 14.h,
              width: 14.w,
              fit: BoxFit.contain,
            ),
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
            color: Color(0xFFE9E9E9),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: CustomText(
            text: value,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Color(0xFF686868),
          ),
        ),
      ],
    );
  }


}
