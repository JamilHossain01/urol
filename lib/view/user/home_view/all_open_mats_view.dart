import 'package:calebshirthum/common widget/custom_app_bar_widget.dart';
import 'package:calebshirthum/common%20widget/custom_elipse_text.dart';
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

  final CurrentLocationService locationService = CurrentLocationService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loadMatsWithLocation();
  }

  Future<void> _loadMatsWithLocation() async {
    /// 1️⃣ Permission
    final granted = await locationService.requestPermission();
    if (!granted) {
      print("❌ Location permission denied");
      return;
    }

    /// 2️⃣ Get current position
    final position = await locationService.getCurrentLocation();
    if (position == null) {
      print("❌ Could not fetch location");
      return;
    }

    /// 3️⃣ Save (optional)
    await locationService.saveLatLong(
      position.latitude,
      position.longitude,
    );

    /// 4️⃣ Call API
    controller.getAllMats(
      lat: position.latitude,
      long: position.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: "All Gym Open Mats"),
      body: Obx(() {
        /// 🔄 Loading
        if (controller.isLoading.value) {
          return ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, index) {
                return Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: ShimmerCardWidgetOfMap());
              });
        }

        /// ❌ No data
        final mats = controller.unread.value.data;
        if (mats == null || mats.isEmpty) {
          return Center(
              child: NotFoundWidget(
            imagePath: "assets/images/not_found.png",
            message: "No open mats found",
          ));
        }

        /// ✅ Data
        return ListView.builder(
          itemCount: mats.length,
          itemBuilder: (context, index) {
            final mat = mats[index];

            /// 🖼️ Safe image
            final imageUrl =
                mat.images.isNotEmpty ? mat.images.first.url ?? "" : "";

            /// 🕒 First mat schedule (if any)
            String time = "N/A";
            String day = "N/A";

            if (mat.matSchedules.isNotEmpty) {
              final schedule = mat.matSchedules.first;
              day = schedule.day ?? "N/A";
              time = "${schedule.fromView ?? ''} - ${schedule.toView ?? ''}";
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: NearbyMatsSection(
                mats: [
                  MatCardData(
                    name: customEllipsisText(mat.name ?? "Unknown Gym",
                        wordLimit: 2),
                    distance: mat.distance != null
                        ? "${(mat.distance! / 1000).toStringAsFixed(1)} km"
                        : "0 km",
                    days: day,
                    time: time,
                    image: imageUrl.isNotEmpty
                        ? imageUrl
                        : "https://via.placeholder.com/150",
                    onTap: () {
                      Get.to(() => GymDetailsScreen(gymId: mat.id.toString()));
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
