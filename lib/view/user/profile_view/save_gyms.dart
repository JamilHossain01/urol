import 'package:calebshirthum/common%20widget/comon_conatainer/custom_conatiner.dart';
import 'package:calebshirthum/common%20widget/custom_app_bar_widget.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../location_view/gym_details_view.dart';
import '../location_view/location_screen_view.dart';

class SaveGymsView extends StatefulWidget {
  const SaveGymsView({super.key});

  @override
  State<SaveGymsView> createState() => _SaveGymsViewState();
}

class _SaveGymsViewState extends State<SaveGymsView> {
  // Dummy list of gyms
  final List<Map<String, String>> gyms = List.generate(
    7,
        (index) => {
      "name": "IBJJF World Championships 202${index + 1}",
      "location": "📍 6157 Rd, California, USA",
      "image": AppImages.gym1,
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: CustomAppBar(title: 'Saved Gyms'),
      body: ListView.builder(
        itemCount: gyms.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final gym = gyms[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: (){
                Get.to(()=>GymDetailsScreen());
              },
              child: CustomContainer(
                height: 250.h,
                width: double.infinity,
                color: Colors.white,
                borderRadius: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.asset(
                        gym["image"]!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: gym["name"]!,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainTextColors,
                          ),
                          CustomText(
                            text: gym["location"]!,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF4B4B4B),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildActivityButton('Open Mats'),
                              _buildActivityButton('BJJ'),
                              _buildActivityButton('MMA'),
                              _buildActivityButton('Boxing'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActivityButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF000000).withOpacity(0.094),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      child: CustomText(
        text: text,
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: Color(0xFF686868),
      ),
    );
  }
}
