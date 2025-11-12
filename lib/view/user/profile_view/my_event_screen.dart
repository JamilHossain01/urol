import 'package:calebshirthum/common%20widget/custom_app_bar_widget.dart';
import 'package:calebshirthum/common%20widget/custom_date_format.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/my_event_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common widget/not_found_widget.dart';
import 'add_events_view.dart';
import 'controller/delete_event_controller.dart';
import 'controller/my_events_controller.dart' show MyEventsController;

class MyEventScreen extends StatefulWidget {
  const MyEventScreen({super.key});

  @override
  State<MyEventScreen> createState() => _MyEventScreenState();
}

class _MyEventScreenState extends State<MyEventScreen> {
  final MyEventsController _myEventsController = Get.put(MyEventsController());
  final DeleteEventController _deleteEventController =
      Get.put(DeleteEventController());

  @override
  void initState() {
    super.initState();
    _myEventsController.getMyEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: const CustomAppBar(
        title: 'My Events',
        showLeadingIcon: true,
      ),
      body: Obx(() {
        if (_myEventsController.isLoading.value) {
          return CustomLoader();
        }

        final events = _myEventsController.gums.value.data ?? [];

        if (events.isEmpty) {
          return Center(
              child: NotFoundWidget(
            imagePath: "assets/images/not_found.png",
            message: "No event found!",
          ));
        }

        return ListView.builder(
          itemCount: events.length,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          itemBuilder: (context, index) {
            final event = events[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: GestureDetector(
                onTap: () {},
                child: MyEventCardWidget(
                  edit: () {
                    Get.to(() => AddEventsView(
                        eventImage: event.image?.url.toString(),
                        eventName: event.name,
                        eventLocation: event.venue,
                        eventDate: event.date.toString(),
                        eventId: event.id,
                        eventWebsite: event.eventWebsite,
                        regFee: event.registrationFee.toString(),
                        isEdit: true));
                  },
                  delete: () {
                    _deleteEventController.deleteGyms(
                        eventId: event.id.toString());
                  },
                  showEditDelete: true,
                  eventName: event.name ?? "Unnamed Event",
                  eventDate:
                      CustomDateFormatter.formatDate(event.date.toString()),
                  location: "${event.city ?? ''}, ${event.state ?? ''}",
                  image: event.image?.url.toString() ?? "",
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
