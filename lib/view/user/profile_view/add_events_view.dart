import 'dart:io';
import 'package:calebshirthum/common%20widget/custom_app_bar_widget.dart';
import 'package:calebshirthum/common%20widget/custom_button_widget.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/image_upload_widget.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../uitilies/app_colors.dart';

class AddEventsView extends StatefulWidget {
  const AddEventsView({super.key});

  @override
  State<AddEventsView> createState() => _AddEventsViewState();
}

class _AddEventsViewState extends State<AddEventsView> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedGym;
  String? selectedEventType;
  String? selectedState;
  String? selectedCity;
  String? zipCode;
  XFile? selectedImage;

  // Latitude & Longitude for LocationWidget
  double? _lat;
  double? _long;

  // Controllers for LocationWidget
  final _streetAddressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();

  final _gyms = ['Gym 1', 'Gym 2', 'Gym 3', 'Gym 4'];
  final _eventTypes = ['Seminar', 'Tournament'];
  final _states = ['State 1', 'State 2', 'State 3'];
  final _cities = ['City 1', 'City 2', 'City 3'];

  // Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Time Picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // Image Picker
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedImage = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: 'Add Events',
        showLeadingIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10.h),

              /// Image Picker
              ImageUploadWidget(),
              Gap(15.h),

              /// Basic Info
              CustomText(
                text: "Basic Information",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mainTextColors,
              ),
              SizedBox(height: 12.h),

              /// Gym Dropdown
              CustomText(
                text: "Select Gym",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textFieldNameColor,
              ),
              Gap(4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.backRoudnColors,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.hintTextColors),
                ),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: const InputDecoration(border: InputBorder.none),
                  value: selectedGym,
                  hint: CustomText(
                    text: "Select Gym",
                    fontSize: 14.sp,
                    color: AppColors.hintTextColors,
                  ),
                  items: _gyms.map((gym) {
                    return DropdownMenuItem<String>(
                      value: gym,
                      child: CustomText(
                        text: gym,
                        fontSize: 14.sp,
                        color: AppColors.mainTextColors,
                      ),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => selectedGym = val),
                ),
              ),
              SizedBox(height: 10.h),

              /// Event Type Dropdown
              CustomText(
                text: "Select Event Type",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textFieldNameColor,
              ),
              Gap(4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.backRoudnColors,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.hintTextColors),
                ),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: const InputDecoration(border: InputBorder.none),
                  value: selectedEventType,
                  hint: CustomText(
                    text: "Select Event Type",
                    fontSize: 14.sp,
                    color: AppColors.hintTextColors,
                  ),
                  items: _eventTypes.map((event) {
                    return DropdownMenuItem<String>(
                      value: event,
                      child: CustomText(
                        text: event,
                        fontSize: 14.sp,
                        color: AppColors.mainTextColors,
                      ),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => selectedEventType = val),
                ),
              ),
              SizedBox(height: 10.h),

              /// Event Name
              CustomText(
                text: "Event Name",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textFieldNameColor,
              ),
              Gap(4.h),
              CustomTextField(
                hintText: "Enter event name",
                showObscure: false,
                fillColor: AppColors.backRoudnColors,
                hintTextColor: AppColors.hintTextColors,
                maxLines: 1,
                validator: (value) =>
                value!.isEmpty ? "Event name is required" : null,
              ),
              SizedBox(height: 10.h),

              /// Event Description
              CustomText(
                text: "Event Description",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textFieldNameColor,
              ),
              Gap(4.h),
              CustomTextField(
                hintText: "Enter event description",
                showObscure: false,
                fillColor: AppColors.backRoudnColors,
                hintTextColor: AppColors.hintTextColors,
                maxLines: 5,
                validator: (value) =>
                value!.isEmpty ? "Description is required" : null,
              ),
              SizedBox(height: 10.h),

              /// Location Picker
              LocationWidget(
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
              SizedBox(height: 10.h),

              /// State & City
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 160.w,
                    padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.backRoudnColors,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.hintTextColors),
                    ),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: const InputDecoration(border: InputBorder.none),
                      value: selectedState,
                      hint: CustomText(
                        text: "State",
                        fontSize: 14.sp,
                        color: AppColors.hintTextColors,
                      ),
                      items: _states.map((state) {
                        return DropdownMenuItem<String>(
                          value: state,
                          child: CustomText(
                            text: state,
                            fontSize: 14.sp,
                            color: AppColors.mainTextColors,
                          ),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => selectedState = val),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Container(
                    width: 160.w,
                    padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.backRoudnColors,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.hintTextColors),
                    ),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: const InputDecoration(border: InputBorder.none),
                      value: selectedCity,
                      hint: CustomText(
                        text: "City",
                        fontSize: 14.sp,
                        color: AppColors.hintTextColors,
                      ),
                      items: _cities.map((city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: CustomText(
                            text: city,
                            fontSize: 14.sp,
                            color: AppColors.mainTextColors,
                          ),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => selectedCity = val),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              /// Zip Code
              CustomText(
                text: "Zip Code",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mainTextColors,
              ),
              Gap(4.h),
              CustomTextField(
                controller: _zipCodeController,
                hintText: "Enter Zip Code",
                showObscure: false,
                fillColor: AppColors.backRoudnColors,
                hintTextColor: AppColors.hintTextColors,
                maxLines: 1,
                validator: (value) =>
                value!.isEmpty ? "Zip Code is required" : null,
              ),
              SizedBox(height: 20.h),

              /// Date & Time
              CustomText(
                text: "Date & Time",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mainTextColors,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          color: AppColors.backRoudnColors,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.hintTextColors),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: selectedDate == null
                                  ? "Select Date"
                                  : "${selectedDate?.toLocal()}".split(' ')[0],
                              fontSize: 14.sp,
                              color: AppColors.hintTextColors,
                            ),
                            Icon(Icons.calendar_today,
                                size: 20, color: AppColors.hintTextColors),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: InkWell(
                      onTap: () => _selectTime(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          color: AppColors.backRoudnColors,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.hintTextColors),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: selectedTime == null
                                  ? "Select Time"
                                  : "${selectedTime?.format(context)}",
                              fontSize: 14.sp,
                              color: AppColors.hintTextColors,
                            ),
                            Icon(Icons.access_time,
                                size: 20, color: AppColors.hintTextColors),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              CustomButtonWidget(
                btnColor: AppColors.mainColor,
                btnText: "Submit",
                onTap: () {
                  debugPrint(
                      "Event Location: $_lat, $_long, Address: ${_streetAddressController.text}");
                },
                iconWant: false,
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
