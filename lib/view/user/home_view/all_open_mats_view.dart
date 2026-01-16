import 'package:calebshirthum/common widget/custom_app_bar_widget.dart';
import 'package:calebshirthum/view/user/home_view/widgets/nearby_mats_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/all_open_mats_controller.dart';

class AllOpenMatsView extends StatefulWidget {
  const AllOpenMatsView({super.key});

  @override
  State<AllOpenMatsView> createState() => _AllOpenMatsViewState();
}

class _AllOpenMatsViewState extends State<AllOpenMatsView> {
  final GetAllOpenMatsController _getAllOpenMatsController =
      Get.put(GetAllOpenMatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "All Open Mats"),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: NearbyMatsSection(
              mats: [
                MatCardData(
                  name: "Mat ${index + 1}",
                  distance: "0 km",
                  days: "N/A",
                  time: "N/A",
                  image:
                      "https://media.licdn.com/dms/image/v2/D5603AQFQn4nyFMrvyA/profile-displayphoto-scale_200_200/B56Zn2fKQsKIAY-/0/1760776990433?e=2147483647&v=beta&t=b2aGFimnXniG5vlLYpGP2_LzQ7T0YX01uAxjgsYKg30",
                  onTap: () {
                    // TODO: handle tap
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
