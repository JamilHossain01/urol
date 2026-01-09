import 'package:calebshirthum/common%20widget/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common widget/custom_date_format.dart';
import '../../../common widget/not_found_widget.dart';
import '../home_view/widgets/shimmer/event_shimmer_portion.dart';
import '../profile_view/controller/delete_event_controller.dart';
import '../profile_view/widgets/event_card.dart';
import 'controller/delete_event_controller.dart';
import 'controller/get_all_event_result_controller.dart';
import 'model/get_all_event_model.dart';

class RecentEventAllView extends StatefulWidget {
  const RecentEventAllView({super.key});

  @override
  State<RecentEventAllView> createState() => _RecentEventAllViewState();
}

class _RecentEventAllViewState extends State<RecentEventAllView> {
  final GetAllEventResultController _controller =
      Get.put(GetAllEventResultController());

  final DeleteResultEventController _deleteEventController =
      Get.put(DeleteResultEventController());

  Color getMedalColor(String? result) {
    switch (result) {
      case "Gold":
        return Colors.amber;
      case "Silver":
        return Colors.grey;
      case "Bronze":
        return Colors.brown;
      case "DNP":
        return Colors.brown;
      default:
        return Colors.grey;
    }
  }

  Widget getMedalIcon(String? result) {
    switch (result) {
      case "Gold":
        return Image.asset("assets/images/gold.png", width: 24, height: 24);
      case "Silver":
        return Image.asset("assets/images/silver.png", width: 24, height: 24);
      case "Bronze":
        return Image.asset("assets/images/bronze.png", width: 24, height: 24);
      case "DNP":
        return Image.asset("assets/images/dnp.png", width: 24, height: 24);
      default:
        return Image.asset("assets/images/dnp.png", width: 24, height: 24);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "All Events Result"),
      body: Obx(() {
        // 1️⃣ Loading
        if (_controller.isLoading.value) {
          return const Center(child: EventCardShimmer());
        }

        final List<CompetitionData> events =
            _controller.profile.value.data ?? [];

        // 2️⃣ No Data
        if (events.isEmpty) {
          return const Center(
            child: NotFoundWidget(
              imagePath: "assets/images/not_found.png",
              message: "No event results yet!",
            ),
          );
        }

        // 3️⃣ List
        return ListView.builder(
          itemCount: events.length,
          itemBuilder: (context, index) {
            final item = events[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: EventCard(
                showAllResult: false,
                onDelete: () {
                  _deleteEventController.deleteResultEvent(
                      eventResultId: item.id);
                },
                showDeleteButton: true,
                medalColor: getMedalColor(item.result),
                medalIcon: getMedalIcon(item.result),
                showCompetition: false,
                title: item.eventName ?? "N/A",
                date: CustomDateFormatter.formatDate(
                  item.eventDate?.toIso8601String() ?? "",
                ),
                division: item.division ?? "N/A",
                location:
                    "${item.city ?? ""}${item.state != null ? ", ${item.state}" : ""}",
                medalText: item.result ?? "N/A",
              ),
            );
          },
        );
      }),
    );
  }
}
