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
import '../location_view/widgets/gym_preview_card.dart';

class SaveGymsView extends StatefulWidget {
  const SaveGymsView({super.key});

  @override
  State<SaveGymsView> createState() => _SaveGymsViewState();
}

class _SaveGymsViewState extends State<SaveGymsView> {
  // Dummy list of gyms
  final List<Map<String, String>> gymList = List.generate(
    7,
        (index) => {
      'gymName': 'GymNation Stars',
      'location': '6157 Rd, California, USA',
      'image': AppImages.gym1, // Use your own image paths here
      'categories': 'Open Mat, BJJ, MMA', // Categories
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backRoudnColors,
        appBar: CustomAppBar(title: 'Saved Gyms'),
        body: ListView.builder(
          // scrollDirection: Axis.vertical,
          itemCount: gymList.length,
          itemBuilder: (context, index) {
            final gym = gymList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 16),
              child: GymPreviewCard(
                gymName: gym['gymName']!,
                location: gym['location']!,
                image: gym['image']!,
                categories: gym['categories']!.split(', '),
              ),
            );
          },
        ));
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
