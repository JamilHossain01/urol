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

class LocationWidget extends StatelessWidget {
  final TextEditingController streetAddressController;
  final dynamic lat;
  final dynamic long;
  final TextEditingController cityController;
  final bool? zipCode;
  final TextEditingController stateController;
  final TextEditingController zipCodeController;
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

  /// ✅ USA States List
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
        initialLat: lat,
        initialLng: long,
        onLocationSelected: (double selLat, double selLng, String address) {
          streetAddressController.text = address;

          placemarkFromCoordinates(selLat, selLng).then((placemarks) {
            if (placemarks.isNotEmpty) {
              final p = placemarks.first;

              cityController.text = p.locality ?? '';
              stateController.text = p.administrativeArea ?? '';
              zipCodeController.text = p.postalCode ?? '';
            }
          }).catchError((e) {
            debugPrint("Reverse geocoding failed: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to fetch address details")),
            );
          });

          if (onLocationChanged != null) {
            onLocationChanged!(selLat, selLng);
          }

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
        /// Location Title
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
        GestureDetector(
          onTap: () => _pickLocation(context),
          child: AbsorbPointer(
            child: CustomTextField(
              controller: streetAddressController,
              hintText: "Tap to pick location from map",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
              validator: (value) =>
                  value!.isEmpty ? "Address is required" : null,
            ),
          ),
        ),

        SizedBox(height: 12.h),

        /// State & City Row
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// STATE DROPDOWN
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
                      isExpanded: true,
                      value: stateController.text.isEmpty
                          ? null
                          : stateController.text,
                      items: usaStates
                          .map(
                            (state) => DropdownMenuItem<String>(
                              value: state,
                              child: Text(
                                state,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        stateController.text = value ?? '';
                      },
                      decoration: InputDecoration(
                        hintText: "State",
                        filled: true,
                        fillColor: AppColors.backRoudnColors,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.4),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.4),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.4),
                            width: 1.5,
                          ),
                        ),
                      ),
                      validator: (value) => value == null || value.isEmpty
                          ? "State is required"
                          : null,
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12.w),

              /// CITY FIELD
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
                      controller: cityController,
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
        ),

        SizedBox(height: 12.h),

        /// ZIP CODE
        if (zipCode != false)
          CustomText(
            text: "Zip Code",
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textFieldNameColor,
          ),
        Gap(4.h),
        if (zipCode != false)
          CustomTextField(
            controller: zipCodeController,
            hintText: "Enter zip code",
            showObscure: false,
            fillColor: AppColors.backRoudnColors,
            hintTextColor: AppColors.hintTextColors,
            validator: (value) =>
                value!.isEmpty ? "Zip code is required" : null,
          ),

        SizedBox(height: 10.h),
      ],
    );
  }
}
