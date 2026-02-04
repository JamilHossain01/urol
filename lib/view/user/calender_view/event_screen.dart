import 'package:calebshirthum/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:calebshirthum/common%20widget/custom_elipse_text.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:calebshirthum/view/user/calender_view/controller/get_event_controller.dart';
import 'package:calebshirthum/view/user/calender_view/widget/card_of_event.dart';
import 'package:calebshirthum/view/user/calender_view/widget/card_of_shimmer_event.dart';
import 'package:calebshirthum/view/user/calender_view/widget/event_bottom_sheet.dart';
import 'package:calebshirthum/view/user/calender_view/widget/filter_event_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../common widget/not_found_widget.dart';
import '../../../common widget/seacr)with_filter_widgets.dart';
import '../../../uitilies/custom_loader.dart';
import '../event_view/widget/event_details_content.dart';
import '../event_view/widget/event_details_modal.dart';
import '../home_view/widgets/shimmer/event_shimmer_portion.dart';

class EventScreenView extends StatefulWidget {
  const EventScreenView({super.key});

  @override
  State<EventScreenView> createState() => _EventScreenViewState();
}

class _EventScreenViewState extends State<EventScreenView> {
  final GetEventController _getEventController = Get.put(GetEventController());

  /// ✅ MULTI EVENT TYPES
  double selectedDistance = 2.0;

  List<String> selectedEventTypes = [];

  @override
  void initState() {
    super.initState();
    _getEventController.getAllEvent(
      searchTerms: '',
      type: '',
      state: '',
      city: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Events',
            style: GoogleFonts.libreBaskerville(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// SEARCH BAR
            SearchBarWithFilter(
              backgroundColor: Colors.grey[200],
              onFilterTap: () => _openFilterSheet(context),
              onSearchChanged: (text) {
                _getEventController.getAllEvent(
                  searchTerms: text,
                  type: selectedEventTypes.join(","),
                  state: '',
                  city: '',
                );
              },
              hintText: 'Search here....',
            ),

            Gap(8.h),

            /// ✅ SELECTED EVENT TYPES TEXT
            CustomText(
              text: selectedEventTypes.isEmpty
                  ? "All Events"
                  : selectedEventTypes.join(", "),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),

            Gap(10.h),

            /// EVENT LIST
            Expanded(
              child: Obx(() {
                if (_getEventController.isLoading.value) {
                  return const Center(child: EventShimmerListScreen());
                }

                final events =
                    _getEventController.allEvent.value.data?.data ?? [];

                if (events.isEmpty) {
                  return const Center(
                    child: NotFoundWidget(
                      imagePath: "assets/images/not_found.png",
                      message: "No event found",
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];

                    String daysLeftText = '';
                    String statusText = 'Open';

                    if (event.date != null) {
                      final diff =
                          event.date!.difference(DateTime.now()).inDays;

                      if (diff > 1) {
                        daysLeftText = "$diff Days Left";
                      } else if (diff == 1) {
                        daysLeftText = "Tomorrow";
                      } else if (diff == 0) {
                        daysLeftText = "Today";
                      } else {
                        daysLeftText = "Event Passed";
                        statusText = "Closed";
                      }
                    } else {
                      daysLeftText = "No Date";
                      statusText = "Closed";
                    }

                    return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16.r)),
                            ),
                            builder: (context) {
                              return EventDetailsBottomSheet(
                                imageUrl: event.image?.url ??
                                    "https://via.placeholder.com/300x200.png",
                                location:
                                    "${event.city ?? ''}, ${event.state ?? ''}, ${event.venue ?? ''}",
                                eventType: event.type ?? "N/A",
                                registrationFee:
                                    "\$${event.registrationFee?.toString() ?? '0'}",
                                link: event.eventWebsite ?? "",
                                day: event.date != null
                                    ? "${event.date!.month}/${event.date!.day}/${event.date!.year}"
                                    : "No Date",
                                staus: statusText,
                              );
                            },
                          );
                        },
                        child: CardOfEvent(
                          date:
                              "${event.date?.month ?? ''}/${event.date?.day ?? ''}/${event.date?.year ?? ''}",
                          title: customEllipsisText(
                            event.name ?? "Unnamed Event",
                            wordLimit: 3,
                          ),
                          org: event.type ?? "",
                          location:
                              "${event.city ?? ''}, ${event.state ?? ''}, ${event.venue ?? ''}",
                          status: statusText,
                          daysLeft: daysLeftText,
                          price:
                              "\$${event.registrationFee?.toString() ?? '0'}",
                          link: event.eventWebsite ?? "",
                          image: event.image?.url ??
                              "https://via.placeholder.com/300x200.png",
                          statusColor:
                              statusText == "Open" ? Colors.green : Colors.red,
                          leftDaysColor:
                              statusText == "Open" ? Colors.green : Colors.red,
                          websiteRedirect: () async {
                            final link = event.eventWebsite;
                            if (link != null && link.isNotEmpty) {
                              await launchUrl(
                                Uri.parse(link),
                                mode: LaunchMode.externalApplication,
                              );
                            } else {
                              CustomToast.showToast(
                                "Invalid event link",
                                isError: true,
                              );
                            }
                          },
                        ));
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _openFilterSheet(BuildContext context) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return FilterBottomSheet(
          distance: selectedDistance,
          initialEventTypes: selectedEventTypes,
        );
      },
    );

    if (result != null) {
      final List<String> eventTypes =
          List<String>.from(result["eventTypes"] ?? []);
      final city = result["city"] ?? "";
      final state = result["state"] ?? "";

      final distance = (result["distance"] ?? selectedDistance).toDouble();

      setState(() {
        selectedEventTypes = eventTypes;
        selectedDistance = distance;
      });

      _getEventController.getAllEvent(
        searchTerms: '',
        type: eventTypes.join(","),
        state: state,
        city: city,
      );
    }
  }
}
