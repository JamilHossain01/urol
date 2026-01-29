// // ignore_for_file: prefer_const_constructors
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_places_flutter/google_places_flutter.dart';
// import 'package:google_places_flutter/model/prediction.dart';
//
// import '../../../../common widget/custom text/custom_text_widget.dart';
// import '../../../../common widget/custom_text_filed.dart';
// import '../../../../uitilies/app_colors.dart';
// import '../../location_view/widgets/location_picker_view.dart';
//
// class LocationWidget extends StatefulWidget {
//   final TextEditingController streetAddressController;
//   final TextEditingController cityController;
//   final TextEditingController stateController;
//   final TextEditingController zipCodeController;
//   final TextEditingController? apartmentController;
//   final double? lat;
//   final double? long;
//   final bool? zipCode;
//   final void Function(double lat, double long)? onLocationChanged;
//
//   const LocationWidget({
//     super.key,
//     required this.streetAddressController,
//     required this.cityController,
//     required this.stateController,
//     required this.zipCodeController,
//     this.lat,
//     this.long,
//     this.onLocationChanged,
//     this.zipCode,
//     this.apartmentController,
//   });
//
//   @override
//   State<LocationWidget> createState() => _LocationWidgetState();
// }
//
// class _LocationWidgetState extends State<LocationWidget> {
//   /// 🔐 MUST pick from map flag
//   bool isLocationPicked = false;
//
//   final FocusNode streetFocusNode = FocusNode();
//
//   /// 🇺🇸 USA States
//   static const List<String> usaStates = [
//     "Alabama",
//     "Alaska",
//     "Arizona",
//     "Arkansas",
//     "California",
//     "Colorado",
//     "Connecticut",
//     "Delaware",
//     "Florida",
//     "Georgia",
//     "Hawaii",
//     "Idaho",
//     "Illinois",
//     "Indiana",
//     "Iowa",
//     "Kansas",
//     "Kentucky",
//     "Louisiana",
//     "Maine",
//     "Maryland",
//     "Massachusetts",
//     "Michigan",
//     "Minnesota",
//     "Mississippi",
//     "Missouri",
//     "Montana",
//     "Nebraska",
//     "Nevada",
//     "New Hampshire",
//     "New Jersey",
//     "New Mexico",
//     "New York",
//     "North Carolina",
//     "North Dakota",
//     "Ohio",
//     "Oklahoma",
//     "Oregon",
//     "Pennsylvania",
//     "Rhode Island",
//     "South Carolina",
//     "South Dakota",
//     "Tennessee",
//     "Texas",
//     "Utah",
//     "Vermont",
//     "Virginia",
//     "Washington",
//     "West Virginia",
//     "Wisconsin",
//     "Wyoming",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         /// Title
//         CustomText(
//           text: "Location",
//           fontSize: 14.sp,
//           fontWeight: FontWeight.w600,
//           color: AppColors.mainTextColors,
//         ),
//         SizedBox(height: 12.h),
//
//         /// Address
//         CustomText(
//           text: "Address",
//           fontSize: 12.sp,
//           fontWeight: FontWeight.w600,
//           color: AppColors.textFieldNameColor,
//         ),
//
//         SizedBox(height: 12.h),
//
//         GooglePlaceAutoCompleteTextField(
//           focusNode: streetFocusNode, // ✅ CORRECT
//           textEditingController: widget.streetAddressController,
//           textInputAction: TextInputAction.done, // or next if you want
//           googleAPIKey: "AIzaSyB_3nOokGz9jksH5jN_f05YNEJeZqWizYM",
//           inputDecoration: InputDecoration(
//             hintText: "Pick location from map",
//             hintStyle: TextStyle(color: AppColors.hintTextColors),
//             filled: true,
//             fillColor: AppColors.backRoudnColors,
//             border: OutlineInputBorder(
//               borderSide: BorderSide.none,
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           debounceTime: 200,
//           countries: ["USA"],
//           isLatLngRequired: true,
//           getPlaceDetailWithLatLng: (Prediction prediction) async {
//             if (prediction.lat != null && prediction.lng != null) {
//               final lat = double.parse(prediction.lat!);
//               final lng = double.parse(prediction.lng!);
//
//               widget.onLocationChanged?.call(lat, lng);
//             }
//           },
//
//           itemClick: (Prediction prediction) {
//             widget.streetAddressController.text = prediction.description ?? "";
//
//             if (prediction.lat != null && prediction.lng != null) {
//               final double latitude = double.parse(prediction.lat!);
//               final double longitude = double.parse(prediction.lng!);
//
//               widget.onLocationChanged?.call(latitude, longitude);
//             }
//
//             streetFocusNode.unfocus();
//           },
//
//           itemBuilder: (context, index, Prediction prediction) {
//             return Container(
//               padding: EdgeInsets.all(10),
//               child: CustomText(
//                   textAlign: TextAlign.start,
//                   text: prediction.description ?? ""),
//             );
//           },
//           seperatedBuilder: Divider(
//             color: Colors.white,
//           ),
//           containerHorizontalPadding: 0,
//         ),
//
//         SizedBox(height: 12.h),
//
//         /// State & City
//         Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomText(
//                     text: "State",
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textFieldNameColor,
//                   ),
//                   SizedBox(height: 4.h),
//                   DropdownButtonFormField<String>(
//                       hint: CustomText(
//                         text: "Select State",
//                       ),
//                       isExpanded: true,
//                       value: usaStates.contains(widget.stateController.text)
//                           ? widget.stateController.text
//                           : null,
//                       items: usaStates
//                           .map(
//                             (state) => DropdownMenuItem(
//                               value: state,
//                               child: Text(state),
//                             ),
//                           )
//                           .toList(),
//                       onChanged: (value) {
//                         widget.stateController.text = value ?? '';
//                         setState(() {});
//                       },
//                       validator: (value) =>
//                           value == null ? "State is required" : null,
//                       decoration: InputDecoration(
//                           filled: true,
//                           fillColor: AppColors.backRoudnColors,
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                               color: Colors.grey.withOpacity(0.4),
//                               width: 1,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                               color: Colors.grey.withOpacity(0.4),
//                               width: 1.5,
//                             ),
//                           ),
//                           errorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                               color: Colors.grey.withOpacity(0.4),
//                               width: 1,
//                             ),
//                           ),
//                           focusedErrorBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                               color: Colors.grey.withOpacity(0.4),
//                               width: 1.5,
//                             ),
//                           ))),
//                 ],
//               ),
//             ),
//             SizedBox(width: 12.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomText(
//                     text: "City",
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textFieldNameColor,
//                   ),
//                   SizedBox(height: 4.h),
//                   CustomTextField(
//                     controller: widget.cityController,
//                     hintText: "Enter City",
//                     showObscure: false,
//                     fillColor: AppColors.backRoudnColors,
//                     hintTextColor: AppColors.hintTextColors,
//                     validator: (value) =>
//                         value!.isEmpty ? "City is required" : null,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//
//         SizedBox(height: 12.h),
//
//         /// Zip Code
//         if (widget.zipCode != false) ...[
//           Row(
//             children: [
//               // Zip Code
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: "Zip Code",
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textFieldNameColor,
//                     ),
//                     Gap(4.h),
//                     CustomTextField(
//                       controller: widget.zipCodeController,
//                       hintText: "Enter zip code",
//                       showObscure: false,
//                       fillColor: AppColors.backRoudnColors,
//                       hintTextColor: AppColors.hintTextColors,
//                       keyboardType: TextInputType.number,
//                       validator: (value) =>
//                           value!.isEmpty ? "Zip code is required" : null,
//                     ),
//                   ],
//                 ),
//               ),
//
//               Gap(12.w),
//
//               // Apartment Number
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CustomText(
//                       text: "Suite",
//                       fontSize: 12.sp,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textFieldNameColor,
//                     ),
//                     Gap(4.h),
//                     CustomTextField(
//                       controller: widget.apartmentController,
//                       hintText: "Suite",
//                       showObscure: false,
//                       fillColor: AppColors.backRoudnColors,
//                       hintTextColor: AppColors.hintTextColors,
//                       keyboardType: TextInputType.text,
//                       validator: (value) => value!.isEmpty
//                           ? "Apartment number is required"
//                           : null,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ],
//     );
//   }
// }
