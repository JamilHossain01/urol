import 'package:calebshirthum/common widget/custom_app_bar_widget.dart';
import 'package:calebshirthum/common widget/custom_elipse_text.dart';
import 'package:calebshirthum/view/user/home_view/widgets/nearby_mats_section.dart';
import 'package:calebshirthum/view/user/home_view/widgets/shimmer/shimmer_card_of_map.dart';
import 'package:calebshirthum/view/user/location_view/gym_details_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common widget/current_location_service.dart';
import '../../../common widget/not_found_widget.dart';
import 'controller/all_open_mats_controller.dart';

class AllOpenMatsView extends StatefulWidget {
  const AllOpenMatsView({super.key});

  @override
  State<AllOpenMatsView> createState() => _AllOpenMatsViewState();
}

class _AllOpenMatsViewState extends State<AllOpenMatsView> {
  final GetAllOpenMatsController controller =
  Get.put(GetAllOpenMatsController());

  final CurrentLocationService locationService =
  Get.put(CurrentLocationService());

  @override
  void initState() {
    super.initState();
    _loadMatsWithLocation();
  }

  Future<void> _loadMatsWithLocation() async {
    final granted = await locationService.requestPermission();
    if (!granted) return;

    final position = await locationService.getCurrentLocation();
    if (position == null) return;

    await locationService.saveLatLong(
      position.latitude,
      position.longitude,
    );

    controller.getAllMats(
      lat: position.latitude,
      long: position.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "All Open Mats"),
      body: Obx(() {
        // 🔄 Loading
        if (controller.isLoading.value) {
          return ListView.builder(
            itemCount: 8,
            itemBuilder: (_, __) => const Padding(
              padding: EdgeInsets.all(10),
              child: ShimmerCardWidgetOfMap(),
            ),
          );
        }

        final gyms = controller.unread.value.data;

        // ❌ No gyms
        if (gyms == null || gyms.isEmpty) {
          return const Center(
            child: NotFoundWidget(
              imagePath: "assets/images/not_found.png",
              message: "No open mats found",
            ),
          );
        }

        // ✅ FLATTEN: Gym → Multiple MatSchedules
        final List<MatCardData> matCards = [];

        for (final gym in gyms) {
          if (gym.matSchedules.isEmpty) continue;

          for (final schedule in gym.matSchedules) {
            if (schedule.day == null || schedule.day!.isEmpty) continue;

            final imageUrl = gym.images.isNotEmpty
                ? gym.images.first.url ?? ""
                : "";

            matCards.add(
              MatCardData(
                name:
                customEllipsisText(gym.name ?? "Unknown Gym", wordLimit: 2),
                distance: gym.distance != null
                    ? "${(gym.distance! / 1000).toStringAsFixed(1)} km"
                    : "0 km",
                days: schedule.day ?? "N/A",
                time:
                "${schedule.fromView ?? ''} - ${schedule.toView ?? ''}",
                image: imageUrl.isNotEmpty
                    ? imageUrl
                    : "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png",
                onTap: () {
                  Get.to(() =>
                      GymDetailsScreen(gymId: gym.id.toString()));
                },
              ),
            );
          }
        }

        // ❌ No schedules
        if (matCards.isEmpty) {
          return const Center(
            child: NotFoundWidget(
              imagePath: "assets/images/not_found.png",
              message: "No open mats found",
            ),
          );
        }

        // ✅ Render
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: NearbyMatsSection(mats: matCards),
          ),
        );
      }),
    );
  }
}
