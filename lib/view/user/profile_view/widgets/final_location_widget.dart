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
  final String stringOfHintText;
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
    required this.stringOfHintText,
  });

  @override
  State<FinalLocationWidget> createState() => _FinalLocationWidgetState();
}

class _FinalLocationWidgetState extends State<FinalLocationWidget> {
  final FocusNode streetFocusNode = FocusNode();

  String? _selectedState; // ✅ VERY IMPORTANT

  @override
  void initState() {
    super.initState();

    /// 🔥 VERY IMPORTANT: controller → dropdown sync
    final controllerState = widget.stateController.text.trim();
    if (usaStatesAbbreviations.contains(controllerState)) {
      _selectedState = controllerState;
    }
  }

  static const List<String> usaStatesAbbreviations = [
    "AL",
    "AK",
    "AZ",
    "AR",
    "CA",
    "CO",
    "CT",
    "DE",
    "FL",
    "GA",
    "HI",
    "ID",
    "IL",
    "IN",
    "IA",
    "KS",
    "KY",
    "LA",
    "ME",
    "MD",
    "MA",
    "MI",
    "MN",
    "MS",
    "MO",
    "MT",
    "NE",
    "NV",
    "NH",
    "NJ",
    "NM",
    "NY",
    "NC",
    "ND",
    "OH",
    "OK",
    "OR",
    "PA",
    "RI",
    "SC",
    "SD",
    "TN",
    "TX",
    "UT",
    "VT",
    "VA",
    "WA",
    "WV",
    "WI",
    "WY",
  ];

  static const Map<String, String> usaStateNameToAbbr = {
    "Alabama": "AL",
    "Alaska": "AK",
    "Arizona": "AZ",
    "Arkansas": "AR",
    "California": "CA",
    "Colorado": "CO",
    "Connecticut": "CT",
    "Delaware": "DE",
    "Florida": "FL",
    "Georgia": "GA",
    "Hawaii": "HI",
    "Idaho": "ID",
    "Illinois": "IL",
    "Indiana": "IN",
    "Iowa": "IA",
    "Kansas": "KS",
    "Kentucky": "KY",
    "Louisiana": "LA",
    "Maine": "ME",
    "Maryland": "MD",
    "Massachusetts": "MA",
    "Michigan": "MI",
    "Minnesota": "MN",
    "Mississippi": "MS",
    "Missouri": "MO",
    "Montana": "MT",
    "Nebraska": "NE",
    "Nevada": "NV",
    "New Hampshire": "NH",
    "New Jersey": "NJ",
    "New Mexico": "NM",
    "New York": "NY",
    "North Carolina": "NC",
    "North Dakota": "ND",
    "Ohio": "OH",
    "Oklahoma": "OK",
    "Oregon": "OR",
    "Pennsylvania": "PA",
    "Rhode Island": "RI",
    "South Carolina": "SC",
    "South Dakota": "SD",
    "Tennessee": "TN",
    "Texas": "TX",
    "Utah": "UT",
    "Vermont": "VT",
    "Virginia": "VA",
    "Washington": "WA",
    "West Virginia": "WV",
    "Wisconsin": "WI",
    "Wyoming": "WY",
  };

  /// 🔥 Reverse geocoding
  Future<void> getAddressFromCoordinates(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      final place = placemarks.first;

      // City & Zip
      widget.cityController.text = place.locality ?? "";
      widget.zipCodeController.text = place.postalCode ?? "";

      // 🔥 STATE HANDLING
      final rawState = place.administrativeArea?.trim();
      String? finalState;

      debugPrint("RAW STATE: $rawState");

      if (rawState != null) {
        // Case 1: already abbreviation (e.g., NY, CA)
        if (usaStatesAbbreviations.contains(rawState)) {
          finalState = rawState;
        }
        // Case 2: full name (e.g., New York)
        else if (usaStateNameToAbbr.containsKey(rawState)) {
          finalState = usaStateNameToAbbr[rawState];
        }
      }

      if (finalState != null) {
        setState(() {
          _selectedState = finalState;
          widget.stateController.text = finalState!;
        });
        debugPrint("✅ AUTO SELECTED STATE: $finalState");
      } else {
        debugPrint("❌ STATE NOT FOUND OR NOT MATCHED: $rawState");
      }
    } catch (e) {
      debugPrint("Geocoding error: $e");
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
        ),
        SizedBox(height: 12.h),

        CustomText(
          text: "Address",
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 12.h),

        /// GOOGLE ADDRESS FIELD
        GooglePlaceAutoCompleteTextField(
          focusNode: streetFocusNode,
          textEditingController: widget.streetAddressController,
          googleAPIKey: "AIzaSyB_3nOokGz9jksH5jN_f05YNEJeZqWizYM",
          countries: const ["USA"],
          isLatLngRequired: true,
          debounceTime: 200,
          inputDecoration: InputDecoration(
            hintText: widget.stringOfHintText,
            filled: true,
            fillColor: AppColors.backRoudnColors,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
          getPlaceDetailWithLatLng: (gpf.Prediction prediction) async {
            if (prediction.lat != null && prediction.lng != null) {
              final lat = double.parse(prediction.lat!);
              final lng = double.parse(prediction.lng!);

              widget.onLocationChanged?.call(lat, lng);
              await getAddressFromCoordinates(lat, lng);
            }
          },
          itemClick: (Prediction prediction) {
            widget.streetAddressController.text = prediction.description ?? "";
            streetFocusNode.unfocus();
          },
          itemBuilder: (context, index, gpf.Prediction prediction) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Text(prediction.description ?? ""),
            );
          },
          seperatedBuilder: const Divider(),
        ),

        SizedBox(height: 12.h),

        /// STATE + CITY
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                hint: CustomText(text: "Select State"),
                value: _selectedState,
                isExpanded: true,
                items: usaStatesAbbreviations
                    .map(
                      (state) => DropdownMenuItem(
                        value: state,
                        child: Text(state),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedState = value;
                    widget.stateController.text = value ?? "";
                  });

                  debugPrint("🟢 MANUAL SELECT STATE: $value");
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade400, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.shade600, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                style: const TextStyle(color: Colors.black),
                dropdownColor: Colors.white,
              ),
            ),
            Gap(12.w),
            Expanded(
              child: CustomTextField(
                controller: widget.cityController,
                hintText: "City",
                showObscure: false,
                fillColor: AppColors.backRoudnColors,
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        /// ZIP + SUITE
        if (widget.zipCode != false)
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: widget.zipCodeController,
                  hintText: "Zip Code",
                  keyboardType: TextInputType.number,
                  showObscure: false,
                  fillColor: AppColors.backRoudnColors,
                ),
              ),
              Gap(12.w),
              Expanded(
                child: CustomTextField(
                  controller: widget.apartmentController,
                  hintText: "Suite",
                  showObscure: false,
                  fillColor: AppColors.backRoudnColors,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
