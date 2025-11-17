import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_button_widget.dart';
import '../../../../uitilies/app_colors.dart';
import '../../profile_view/widgets/location_widget.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? selectedEventType = "AGF";

  // -------------------------
  // Added Controllers
  // -------------------------
  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  // -------------------------
  // Added Lat/Long Variables
  // -------------------------
  double? _lat;
  double? _long;

  @override
  void dispose() {
    _streetAddressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 18,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                CustomText(
                  text: "Filter",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mainTextColors,
                ),
                Container(width: 45),
              ],
            ),
            Gap(15.h),

            // Event Types
            CustomText(
              text: "Event type",
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.mainTextColors,
            ),
            Gap(8.h),

            Wrap(
              spacing: 8.w,
              children: [
                "AGF",
                "IBJJF",
                "NAGA",
                "ADCC",
                "Local",
                "Tournament",
                "Seminar"
              ]
                  .map(
                    (type) => ChoiceChip(
                      backgroundColor: const Color(0xFFF5F5F5),
                      label: CustomText(
                        text: type,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: selectedEventType == type
                            ? Colors.white
                            : Colors.black,
                      ),
                      selected: selectedEventType == type,
                      selectedColor: AppColors.mainColor,
                      onSelected: (_) {
                        setState(() {
                          selectedEventType = type;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),

            Gap(15.h),

            // Location Widget
            LocationWidget(
              zipCode: false,
              streetAddressController: _streetAddressController,
              cityController: _cityController,
              stateController: _stateController,
              zipCodeController: _zipCodeController,
              lat: _lat,
              long: _long,
              onLocationChanged: (lat, long) {
                setState(() {
                  _lat = lat;
                  _long = long;
                });
                debugPrint("Selected Lat: $lat, Lng: $long");
              },
            ),

            // Apply Button
            CustomButtonWidget(
              btnColor: AppColors.mainColor,
              btnTextColor: Colors.white,
              btnText: 'Apply Filter',
              onTap: () {
                Navigator.pop(context, {
                  "eventType": selectedEventType,
                  "city": _cityController.text.trim(),
                  "state": _stateController.text.trim(),
                });
              },
              iconWant: false,
            ),


            Gap(10.h),
          ],
        ),
      ),
    );
  }
}
