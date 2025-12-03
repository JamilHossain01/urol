// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:apple_maps_flutter/apple_maps_flutter.dart';

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
            }
          }).catchError((e) {
            debugPrint("Reverse geocoding failed: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Failed to fetch address details")),
            );
          });

          // Send lat/long back to parent screen
          if (onLocationChanged != null) {
            onLocationChanged!(selLat, selLng);
          }

          Get.back(); // Close bottom sheet
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
        CustomText(
          text: "Location",
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.mainTextColors,
        ),
        SizedBox(height: 12.h),
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
                  CustomTextField(
                    controller: stateController,
                    hintText: "Enter State",
                    showObscure: false,
                    fillColor: AppColors.backRoudnColors,
                    hintTextColor: AppColors.hintTextColors,
                    validator: (value) =>
                        value!.isEmpty ? "State is required" : null,
                  ),
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
        SizedBox(height: 12.h),
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
        SizedBox(height: 20.h),
      ],
    );
  }
}

// ===== LocationPickerModal =====
