import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../event_view/widget/event_details_content.dart';

class EventDetailsBottomSheet extends StatelessWidget {
  final String imageUrl;
  final String location;
  final String eventType;
  final String registrationFee;
  final String day;
  final String staus;
  final String link;

  const EventDetailsBottomSheet({
    super.key,
    required this.imageUrl,
    required this.location,
    required this.eventType,
    required this.registrationFee,
    required this.day,
    required this.staus,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 0.95, // ✅ প্রথমে অর্ধেক
        minChildSize: 0.85,
        maxChildSize: 0.95, // ✅ স্ক্রল করলে প্রায় full
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              children: [
                /// 🔘 Drag Handle
                SizedBox(height: 8.h),
                Container(
                  height: 4.h,
                  width: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                Gap(10.h),

                /// 🔝 Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 40),
                      CustomText(
                        text: "Event Details",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainTextColors,
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: AppColors.mainColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),

                /// 📜 Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: EventDetailsContent(
                      imageUrl: imageUrl,
                      location: location,
                      eventType: eventType,
                      registrationFee: registrationFee,
                      day: day,
                      staus: staus,
                      link: link,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
