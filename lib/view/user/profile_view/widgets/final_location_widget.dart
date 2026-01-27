import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart' as gpf;
import 'package:google_places_flutter/model/prediction.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_text_filed.dart';
import '../../../../uitilies/app_colors.dart';

class FinalLocationWidget extends StatefulWidget {
  final TextEditingController streetAddressController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController zipCodeController;
  final TextEditingController? apartmentController;
  final double? lat;
  final double? long;
  final bool? zipCode;
  final void Function(double lat, double long)? onLocationChanged;

  const FinalLocationWidget({
    super.key,
    required this.streetAddressController,
    required this.cityController,
    required this.stateController,
    required this.zipCodeController,
    this.lat,
    this.long,
    this.onLocationChanged,
    this.zipCode,
    this.apartmentController,
  });

  @override
  State<FinalLocationWidget> createState() => _FinalLocationWidgetState();
}

class _FinalLocationWidgetState extends State<FinalLocationWidget> {
  bool isLocationPicked = false;
  final FocusNode streetFocusNode = FocusNode();

  Future<void> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      // Use the geocoding package to get address details
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      // Extract the components of the address
      Placemark placemark = placemarks.first;

      // Update the controllers with the fetched data
      widget.cityController.text = placemark.locality ?? "";
      widget.stateController.text = placemark.administrativeArea ?? "";
      widget.zipCodeController.text = placemark.postalCode ?? "";
    } catch (e) {
      print("Error getting address from coordinates: $e");
    }
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
        SizedBox(height: 12.h),
        GooglePlaceAutoCompleteTextField(
          focusNode: streetFocusNode,
          textEditingController: widget.streetAddressController,
          textInputAction: TextInputAction.done,
          googleAPIKey: "AIzaSyB_3nOokGz9jksH5jN_f05YNEJeZqWizYM",
          inputDecoration: InputDecoration(
            hintText: "Pick location from map",
            hintStyle: TextStyle(color: AppColors.hintTextColors),
            filled: true,
            fillColor: AppColors.backRoudnColors,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          debounceTime: 200,
          countries: ["USA"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (gpf.Prediction prediction) async {
            if (prediction.lat != null && prediction.lng != null) {
              final lat = double.parse(prediction.lat!);
              final lng = double.parse(prediction.lng!);

              widget.onLocationChanged?.call(lat, lng);

              // Fetch the state, city, and zip code after selecting the address
              await getAddressFromCoordinates(lat, lng);
            }
          },
          itemClick: (Prediction prediction) {
            widget.streetAddressController.text = prediction.description ?? "";

            if (prediction.lat != null && prediction.lng != null) {
              final double latitude = double.parse(prediction.lat!);
              final double longitude = double.parse(prediction.lng!);

              widget.onLocationChanged?.call(latitude, longitude);

              // Fetch the state, city, and zip code after selecting the address
              getAddressFromCoordinates(latitude, longitude);
            }

            streetFocusNode.unfocus();
          },
          itemBuilder: (context, index, gpf.Prediction prediction) {
            return Container(
              padding: EdgeInsets.all(10),
              child: CustomText(
                textAlign: TextAlign.start,
                text: prediction.description ?? "",
              ),
            );
          },
          seperatedBuilder: Divider(
            color: Colors.white,
          ),
          containerHorizontalPadding: 0,
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
                  SizedBox(height: 4.h),
                  CustomTextField(
                    controller: widget.stateController,
                    hintText: "Enter state",
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
        if (widget.zipCode != false) ...[
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      keyboardType: TextInputType.number,
                      validator: (value) =>
                          value!.isEmpty ? "Zip code is required" : null,
                    ),
                  ],
                ),
              ),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Suite",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textFieldNameColor,
                    ),
                    Gap(4.h),
                    CustomTextField(
                      controller: widget.apartmentController,
                      hintText: "Suite",
                      showObscure: false,
                      fillColor: AppColors.backRoudnColors,
                      hintTextColor: AppColors.hintTextColors,
                      keyboardType: TextInputType.text,
                      validator: (value) => value!.isEmpty
                          ? "Apartment number is required"
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
