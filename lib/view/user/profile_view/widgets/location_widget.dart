// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_text_filed.dart';
import '../../../../uitilies/app_colors.dart';
import '../../location_view/widgets/location_picker_view.dart';

class LocationWidget extends StatefulWidget {
  final TextEditingController streetAddressController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController zipCodeController;
  final double? lat;
  final double? long;
  final bool? zipCode;
  final void Function(double lat, double long)? onLocationChanged;

  const LocationWidget({
    super.key,
    required this.streetAddressController,
    required this.cityController,
    required this.stateController,
    required this.zipCodeController,
    this.lat,
    this.long,
    this.onLocationChanged,
    this.zipCode,
  });

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  /// 🔐 MUST pick from map flag
  bool isLocationPicked = false;

  /// 🇺🇸 USA States
  static const List<String> usaStates = [
    "Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi",
    "Missouri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "New York",
    "North Carolina",
    "North Dakota",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Vermont",
    "Virginia",
    "Washington",
    "West Virginia",
    "Wisconsin",
    "Wyoming",
  ];

  Future<void> _pickLocation(BuildContext context) async {
    await Get.bottomSheet(
      LocationPickerModal(
        initialLat: widget.lat,
        initialLng: widget.long,
        onLocationSelected:
            (double selLat, double selLng, String address) async {
          widget.streetAddressController.text = address;
          isLocationPicked = true;
          setState(() {});

          try {
            final placemarks = await placemarkFromCoordinates(selLat, selLng);
            if (placemarks.isNotEmpty) {
              final p = placemarks.first;

              // City
              widget.cityController.text = p.locality ?? '';

              // State: Only set if exists in USA list
              final String pickedState = p.administrativeArea ?? '';
              if (usaStates.contains(pickedState)) {
                widget.stateController.text = pickedState;
              } else {
                widget.stateController.clear();
              }

              // Zip code
              widget.zipCodeController.text = p.postalCode ?? '';
            }
          } catch (e) {
            debugPrint("Reverse geocoding failed: $e");
          }

          widget.onLocationChanged?.call(selLat, selLng);
          Get.back();
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title
        CustomText(
          text: "Location",
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.mainTextColors,
        ),
        SizedBox(height: 12.h),

        /// Address
        CustomText(
          text: "Address",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        Gap(4.h),

        CustomTextField(
          controller: widget.streetAddressController,
          hintText: "Pick location from map",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
          validator: (value) {
            if (!isLocationPicked) return "Please select location from map";
            if (value == null || value.isEmpty) return "Address is required";
            return null;
          },
          suffixIcon: IconButton(
            icon: Icon(
              Icons.location_on_outlined,
              color: AppColors.mainTextColors,
            ),
            onPressed: () => _pickLocation(context),
          ),
        ),

        SizedBox(height: 12.h),

        /// State & City
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "State",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textFieldNameColor,
                  ),
                  SizedBox(height: 4.h),
                  DropdownButtonFormField<String>(
                      hint: CustomText(
                        text: "Select State",
                      ),
                      isExpanded: true,
                      value: usaStates.contains(widget.stateController.text)
                          ? widget.stateController.text
                          : null,
                      items: usaStates
                          .map(
                            (state) => DropdownMenuItem(
                              value: state,
                              child: Text(state),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        widget.stateController.text = value ?? '';
                        setState(() {});
                      },
                      validator: (value) =>
                          value == null ? "State is required" : null,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.backRoudnColors,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.4),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.4),
                              width: 1.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.4),
                              width: 1,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.4),
                              width: 1.5,
                            ),
                          ))),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "City",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textFieldNameColor,
                  ),
                  SizedBox(height: 4.h),
                  CustomTextField(
                    controller: widget.cityController,
                    hintText: "Enter City",
                    showObscure: false,
                    fillColor: AppColors.backRoudnColors,
                    hintTextColor: AppColors.hintTextColors,
                    validator: (value) =>
                        value!.isEmpty ? "City is required" : null,
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        /// Zip Code
        if (widget.zipCode != false) ...[
          CustomText(
            text: "Zip Code",
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textFieldNameColor,
          ),
          Gap(4.h),
          CustomTextField(
            controller: widget.zipCodeController,
            hintText: "Enter zip code",
            showObscure: false,
            fillColor: AppColors.backRoudnColors,
            hintTextColor: AppColors.hintTextColors,
            validator: (value) =>
                value!.isEmpty ? "Zip code is required" : null,
          ),
        ],
      ],
    );
  }
}
