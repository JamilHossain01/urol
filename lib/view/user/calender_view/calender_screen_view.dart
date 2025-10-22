import 'package:calebshirthum/common%20widget/custom_app_bar_widget.dart';
import 'package:calebshirthum/view/user/calender_view/widget/card_of_event.dart';
import 'package:calebshirthum/view/user/calender_view/widget/filter_event_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/seacr)with_filter_widgets.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/app_images.dart';

class EventScreenView extends StatefulWidget {
  const EventScreenView({super.key});

  @override
  State<EventScreenView> createState() => _EventScreenViewState();
}

class _EventScreenViewState extends State<EventScreenView> {
  String selectedEventType = "IBJJF";
  double distance = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(

        title: 'Events',
        showLeadingIcon: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(15.h),

            SearchBarWithFilter(
              backgroundColor: Color(0xFFF5F6F8),
              onFilterTap: () {
                _openFilterSheet(context);
                
              },
            ),
            Gap(20.h),

            // Example Section Header
            CustomText(
              text: "September 2025",
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.mainTextColors,
            ),
            Gap(10.h),

            Expanded(
              child: ListView(
                children: [
                  CardOfEvent(
                    date: "SEP\n20\n2025",
                    title:
                        "Rio Summer International Open IBJJF Jiu-Jitsu No-Gi Championship 2025",
                    org: "IBJJF",
                    location: "Arena Carioca 1, Parque Olimpico",
                    status: "Open Registration",
                    daysLeft: "2 Days",
                    price: "\$120",
                    link: "Tap to register on IBJJF website",
                    image: AppImages.gym1,
                  ),
                  CardOfEvent(
                    date: "SEP\n21\n2025",
                    title:
                        "Rio Summer Kids International Open IBJJF Jiu-Jitsu Championship 2025",
                    org: "IBJJF",
                    location: "Arena Carioca 1, Parque Olimpico",
                    status: "Open Registration",
                    daysLeft: "2 Days",
                    price: "\$120",
                    link: "Tap to register on IBJJF website",
                    image: AppImages.gym2,
                  ),
                ],
              ),
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
        return FilterBottomSheet();
      },
    );
  }
}
