import 'package:calebshirthum/common%20widget/comon_conatainer/custom_conatiner.dart';
import 'package:calebshirthum/common%20widget/custom_app_bar_widget.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/view/user/location_view/gym_details_view.dart';
import 'package:calebshirthum/view/user/profile_view/controller/delete_saved_gym_controller.dart';
import 'package:calebshirthum/view/user/profile_view/model/saved_gym_model.dart';
import 'package:calebshirthum/view/user/profile_view/save_gyms_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/not_found_widget.dart';
import '../location_view/widgets/gym_preview_card.dart';
import 'controller/get_saved_gym_controller.dart';

class SaveGymsView extends StatefulWidget {
  const SaveGymsView({super.key});

  @override
  State<SaveGymsView> createState() => _SaveGymsViewState();
}

class _SaveGymsViewState extends State<SaveGymsView> {
  final GetSavedGymController _getSavedGymController =
      Get.put(GetSavedGymController());

  final DeleteSavedController _deleteSavedController =
      Get.put(DeleteSavedController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSavedGymController.getSavedGym();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: const CustomAppBar(
        title: 'Saved Gyms',
        showLeadingIcon: true,
      ),
      body: Obx(() {
        if (_getSavedGymController.isLoading.value) {
          return Center(child: CustomLoader());
        }

        final gymList = _getSavedGymController.gums.value.data ?? [];

        if (gymList.isEmpty) {
          return Center(
              child: NotFoundWidget(
            imagePath: "assets/images/not_found.png",
            message: "No bookmarked gym found!",
          ));
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          itemCount: gymList.length,
          itemBuilder: (context, index) {
            final gym = gymList[index];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => GymDetailsScreen(gymId: gym.id.toString(),));
                },
                child: GymPreviewCard(
                  gymName: gym.gym?.name.toString() ?? "n/a",
                  location: gym.gym?.street.toString() ?? "n/a",
                  image: gym.gym?.images.first.url ?? '',
                  categories: gym.gym?.disciplines ?? [],
                  showDelete: true,
                  showEdit: false,
                  delete: () {
                    _deleteSavedController.deleteBookmarksGyms(
                        gymId: gym.gym?.id.toString());
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }

  // Optional helper for tags or buttons (not used directly here)
  Widget _buildActivityButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF000000).withOpacity(0.094),
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
        color: const Color(0xFF686868),
      ),
    );
  }
}
