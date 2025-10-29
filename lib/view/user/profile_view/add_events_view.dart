import 'dart:io';
import 'package:calebshirthum/common%20widget/custom_app_bar_widget.dart';
import 'package:calebshirthum/common%20widget/custom_button_widget.dart';
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

  final _gyms = ['Gym 1', 'Gym 2', 'Gym 3', 'Gym 4'];
  final _eventTypes = [
    'Seminar',
    'Tournament',
  ]; // Event types
  final _states = ['State 1', 'State 2', 'State 3'];
  final _cities = ['City 1', 'City 2', 'City 3'];

  // Date Picker function
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Time Picker function
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // Image Picker function
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
      appBar: CustomAppBar(
        title: 'Add Events',
        showLeadingIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(4.h),

              CustomText(
                text: "Upload Event Image",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mainTextColors,
              ),
              Gap(5.h),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: EdgeInsets.all(12.h),
                  decoration: BoxDecoration(
                    color: AppColors.backRoudnColors,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.hintTextColors),
                  ),
                  child: selectedImage == null
                      ? Icon(Icons.camera_alt,
                          size: 30, color: AppColors.hintTextColors)
                      : Image.file(
                          File(selectedImage!.path),
                          width: 100.w,
                          height: 100.h,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Gap(10.h),

              CustomText(
                text: "Basic Information",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mainTextColors,
              ),
              SizedBox(height: 12.h),

              CustomText(
                text: "Select Gym",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textFieldNameColor,
              ),
              Gap(4.h),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h), // Reduced vertical padding
                decoration: BoxDecoration(
                  color: AppColors.backRoudnColors,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.hintTextColors),
                ),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  value: selectedGym,
                  hint: CustomText(
                    text: "Select Gym",
                    fontSize: 14.sp,
                    color: AppColors.hintTextColors,
                  ),
                  items: _gyms.map<DropdownMenuItem<String>>((String gym) {
                    return DropdownMenuItem<String>(
                      value: gym,
                      child: CustomText(
                        text: gym,
                        fontSize: 14.sp,
                        color: AppColors.mainTextColors,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGym = newValue;
                    });
                  },
                ),
              ),

              SizedBox(height: 10.h),

              // Event Type Dropdown
              CustomText(
                text: "Select Event Type",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textFieldNameColor,
              ),
              Gap(4.h),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h), // Reduced vertical padding
                decoration: BoxDecoration(
                  color: AppColors.backRoudnColors,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.hintTextColors),
                ),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  value: selectedEventType,
                  hint: CustomText(
                    text: "Select Event Type",
                    fontSize: 14.sp,
                    color: AppColors.hintTextColors,
                  ),
                  items:
                      _eventTypes.map<DropdownMenuItem<String>>((String event) {
                    return DropdownMenuItem<String>(
                      value: event,
                      child: CustomText(
                        text: event,
                        fontSize: 14.sp,
                        color: AppColors.mainTextColors,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedEventType = newValue;
                    });
                  },
                ),
              ),
              SizedBox(height: 10.h),

              // Event Name Field
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

              // Event Description Field
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
              CustomText(
                text: "Location",
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.mainTextColors,
              ),
              SizedBox(height: 10.h),
              CustomText(
                text: "Event Location",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textFieldNameColor,
              ),
              Gap(4.h),
              CustomTextField(
                hintText: "Enter event location",
                showObscure: false,
                fillColor: AppColors.backRoudnColors,
                hintTextColor: AppColors.hintTextColors,
                maxLines: 1,
                validator: (value) =>
                    value!.isEmpty ? "Location is required" : null,
              ),
              SizedBox(height: 10.h),

              // State & City Dropdowns in a Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // State Dropdown
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      value: selectedState,
                      hint: CustomText(
                        text: "State",
                        fontSize: 14.sp,
                        color: AppColors.hintTextColors,
                      ),
                      items:
                          _states.map<DropdownMenuItem<String>>((String state) {
                        return DropdownMenuItem<String>(
                          value: state,
                          child: CustomText(
                            text: state,
                            fontSize: 14.sp,
                            color: AppColors.mainTextColors,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedState = newValue;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),

                  // City Dropdown
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
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      value: selectedCity,
                      hint: CustomText(
                        text: "City",
                        fontSize: 14.sp,
                        color: AppColors.hintTextColors,
                      ),
                      items:
                          _cities.map<DropdownMenuItem<String>>((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: CustomText(
                            text: city,
                            fontSize: 14.sp,
                            color: AppColors.mainTextColors,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCity = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              // Zip Code Text Field
              CustomText(
                text: "Zip Code",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mainTextColors,
              ),
              Gap(4.h),
              CustomTextField(
                hintText: "Enter Zip Code",
                showObscure: false,
                fillColor: AppColors.backRoudnColors,
                hintTextColor: AppColors.hintTextColors,
                maxLines: 1,
                validator: (value) =>
                    value!.isEmpty ? "Zip Code is required" : null,
              ),
              SizedBox(height: 10.h),

              // Event Ticket Field
              CustomText(
                text: "Event Ticket (if ticket available)",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mainTextColors,
              ),
              Gap(4.h),
              CustomTextField(
                hintText: "Paste your event ticket link",
                showObscure: false,
                fillColor: AppColors.backRoudnColors,
                hintTextColor: AppColors.hintTextColors,
                maxLines: 1,
                validator: (value) =>
                    value!.isEmpty ? "Location is required" : null,
              ),
              SizedBox(height: 10.h),
              CustomText(
                text: "Date & Time",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mainTextColors,
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  // Event Date
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

                  // Event Time
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
                  onTap: () {},
                  iconWant: false),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
