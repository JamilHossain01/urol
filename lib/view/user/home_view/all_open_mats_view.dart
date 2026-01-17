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
  final GetAllOpenMatsController controller =
      Get.put(GetAllOpenMatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "All Open Mats"),
      body: Obx(() {
        /// 🔄 Loading
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        /// ❌ No data
        if (controller.unread.value.data == null ||
            controller.unread.value.data!.isEmpty) {
          return const Center(
            child: Text("No open mats found"),
          );
        }

        /// ✅ Data loaded
        final mats = controller.unread.value.data!;

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: mats.length,
          itemBuilder: (context, index) {
            final mat = mats[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NearbyMatsSection(
                mats: [
                  MatCardData(
                    name: mat.gymName ?? "N/A",
                    distance: "0 km",
                    days: mat.day ?? "N/A",
                    time: "${mat.fromView ?? ''} - ${mat.toView ?? ''}",
                    image: mat.gymImages[0].url.toString(),
                    onTap: () {
                      print("Tapped mat: ${mat.gymName}");
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
