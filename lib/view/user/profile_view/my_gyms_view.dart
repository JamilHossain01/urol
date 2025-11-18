import 'package:calebshirthum/common%20widget/custom_app_bar_widget.dart';
import 'package:calebshirthum/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/view/user/location_view/widgets/gym_preview_card.dart';
import 'package:calebshirthum/view/user/profile_view/controller/my_gym_controller.dart';
import 'package:calebshirthum/view/user/profile_view/edite_gyms_details.dart';
import 'package:calebshirthum/view/user/profile_view/save_gyms_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common widget/not_found_widget.dart';
import '../location_view/gym_details_view.dart';
import 'controller/delete_gym_controller.dart';

class MyGymsView extends StatefulWidget {
  const MyGymsView({super.key});

  @override
  State<MyGymsView> createState() => _MyGymsViewState();
}

class _MyGymsViewState extends State<MyGymsView> {
  final MyGymController _myGymController = Get.put(MyGymController());
  final DeleteGymController _deleteGymController =
      Get.put(DeleteGymController());

  @override
  void initState() {
    super.initState();
    _myGymController.getMyGyms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: const CustomAppBar(
        title: 'My Gyms',
        showLeadingIcon: true,
      ),
      body: Obx(() {
        if (_myGymController.isLoading.value) {
          return CustomLoader();
        }

        final gyms = _myGymController.gums.value.data ?? [];

        if (gyms.isEmpty) {
          return Center(
              child: NotFoundWidget(
            imagePath: "assets/images/not_found.png",
            message: "No Gym found!",
          ));
        }

        return ListView.builder(
          itemCount: gyms.length,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          itemBuilder: (context, index) {
            final gym = gyms[index];

            final imageUrl =
                (gym.images.isNotEmpty && gym.images.first.url != null)
                    ? gym.images.first.url!
                    : "https://via.placeholder.com/300x200.png?text=No+Image";

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => GymDetailsScreen(
                        gymId: gym.id.toString(),
                      ));
                },
                child: GymPreviewCard(
                  editTap: () {
                    Get.to(() => EditGymView(
                          gymDisciplines: gym.disciplines,
                          gymImages: gym.images
                              .map((e) => e.url)
                              .where((url) => url != null)
                              .cast<String>()
                              .toList(),
                          gymId: gym.id.toString(),
                          gymName: gym.name ?? "",
                          gymDescription: gym.description ?? "",
                          gymStreetAddress: gym.street ?? "",
                          gymCity: gym.city ?? "",
                          gymState: gym.state ?? "",
                          gymZipCode: gym.zipCode ?? "",
                          gymPhone: gym.phone ?? "",
                          gymEmail: gym.email ?? "",
                          gymWebsite: gym.website ?? "",
                          gymFacebook: gym.facebook ?? "",
                          gymInstagram: gym.instagram ?? "",
                          gymClassName: gym.name ?? "",
                        ));
                  },
                  delete: () {
                    _deleteGymController.deleteGyms(gymId: gym.id.toString());
                  },
                  showDelete: true,
                  showEdit: true,
                  gymName: gym.name ?? "Unnamed Gym",
                  location: "${gym.city ?? ''}, ${gym.state ?? ''}",
                  image: imageUrl,
                  categories: gym.disciplines,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
