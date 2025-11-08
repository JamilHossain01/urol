import 'package:calebshirthum/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/view/user/calender_view/controller/get_event_controller.dart';
import 'package:calebshirthum/view/user/calender_view/widget/card_of_event.dart';
import 'package:calebshirthum/view/user/calender_view/widget/filter_event_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common widget/not_found_widget.dart';
import '../../../common widget/seacr)with_filter_widgets.dart';
import '../../../uitilies/custom_loader.dart';

class EventScreenView extends StatefulWidget {
  const EventScreenView({super.key});

  @override
  State<EventScreenView> createState() => _EventScreenViewState();
}

class _EventScreenViewState extends State<EventScreenView> {
  final GetEventController _getEventController = Get.put(GetEventController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getEventController.getAllEvent(
        searchTerms: '', type: '', state: '', city: '');
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
            SearchBarWithFilter(
              backgroundColor: Colors.grey[200],
              onFilterTap: () {
                _openFilterSheet(context);
              },
              onSearchChanged: (text) {
                _getEventController.getAllEvent(
                    searchTerms: text, type: '', state: '', city: '');
              },
            ),
            Gap(20.h),
            CustomText(
              text: "${_getCurrentMonthName()} ${DateTime.now().year}",
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.mainTextColors,
            ),
            Gap(10.h),
            Expanded(
              child: Obx(() {
                if (_getEventController.isLoading.value) {
                  return Center(
                    child: CustomLoader(),
                  );
                }

                final events =
                    _getEventController.allEvent.value.data?.data ?? [];

                if (events.isEmpty) {
                  return Center(
                      child: Center(
                          child: NotFoundWidget(
                    imagePath: "assets/images/not_found.png",
                    message: "No data found",
                  )));
                }

                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return CardOfEvent(
                      date:
                          "${event.date?.month ?? ''}/${event.date?.day ?? ''}\n${event.date?.year ?? ''}",
                      title: event.name ?? "Unnamed Event",
                      org: event.type ?? "",
                      location:
                          "${event.city ?? ''}, ${event.state ?? ''}, ${event.venue ?? ''}",
                      status: "Open Registration", // Static placeholder
                      daysLeft: "2 Days", // Optional logic can be added
                      price:
                          "\$${event.registrationFee?.toString() ?? '0'}", // Dynamic
                      link: event.eventWebsite ?? "No website",
                      image: event.image?.url ??
                          "https://via.placeholder.com/300x200.png?text=No+Image",
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) {
        return const FilterBottomSheet();
      },
    );
  }

  // ✅ Helper: Get Current Month Name
  String _getCurrentMonthName() {
    final months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return months[DateTime.now().month - 1];
  }
}
