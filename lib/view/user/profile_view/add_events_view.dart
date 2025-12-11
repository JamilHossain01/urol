import 'dart:io';
import 'package:calebshirthum/common%20widget/custom_app_bar_widget.dart';
import 'package:calebshirthum/common%20widget/custom_button_widget.dart';
import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:calebshirthum/view/user/profile_view/controller/add_event_controller.dart';
import 'package:calebshirthum/view/user/profile_view/controller/my_gym_controller.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/image_upload_widget.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/location_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../uitilies/app_colors.dart';
import 'controller/edit_event_controller.dart';

class AddEventsView extends StatefulWidget {
  final bool isEdit;
  final String? eventId;
  final String? eventName;
  final String? eventDate;
  final String? eventTime;
  final String? eventLocation;
  final String? eventImage;
  final String? eventWebsite;
  final String? regFee;
  final String? zipCode;
  final String? image;
  final String? gymId;

  const AddEventsView({
    super.key,
    required this.isEdit,
    this.eventId,
    this.eventName,
    this.eventDate,
    this.eventTime,
    this.eventLocation,
    this.eventImage,
    this.eventWebsite,
    this.regFee,
    this.zipCode,
    this.gymId,
    this.image,
  });

  @override
  State<AddEventsView> createState() => _AddEventsViewState();
}

class _AddEventsViewState extends State<AddEventsView> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedGym;
  String? selectedEventType;

  double? _lat;
  double? _long;

  final _streetAddressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _nameController = TextEditingController();
  final _registrationController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();

  XFile? selectedImage;

  final _eventTypes = ['Seminar', 'Tournament'];

  final AddEventController _addEventController = Get.put(AddEventController());
  final MyGymController _myGymController = Get.put(MyGymController());
  final EditEventController _editEventController =
      Get.put(EditEventController());

  @override
  void initState() {
    super.initState();
    _myGymController.getMyGyms();

    // Initialize edit data
    if (widget.isEdit) {
      _nameController.text = widget.eventName ?? '';
      _websiteController.text = widget.eventWebsite ?? '';
      _registrationController.text = widget.regFee ?? '';
      _streetAddressController.text = widget.eventLocation ?? '';
      _zipCodeController.text = widget.zipCode ?? '';

      if (widget.eventDate != null && widget.eventDate!.isNotEmpty) {
        selectedDate = DateTime.tryParse(widget.eventDate!);
      }
      if (widget.eventTime != null && widget.eventTime!.isNotEmpty) {
        final parts = widget.eventTime!.split(':');
        if (parts.length >= 2) {
          selectedTime = TimeOfDay(
            hour: int.tryParse(parts[0]) ?? 0,
            minute: int.tryParse(parts[1]) ?? 0,
          );
        }
      }

      selectedGym = widget.gymId;

      selectedEventType =
          _eventTypes.contains(widget.eventName) ? widget.eventName : null;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: widget.isEdit ? 'Edit Event' : "Add Events",
        showLeadingIcon: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10.h),

              ImageUploadWidget(
                selectedImage: selectedImage,
                initialImageUrl: widget.image ?? widget.eventImage,
                onImagePicked: (image) {
                  setState(() {
                    selectedImage = image;
                  });
                },
              ),

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
              Obx(() {
                final gyms = _myGymController.gums.value.data ?? [];

                // Reset selectedGym if not found in the list
                if (selectedGym != null &&
                    !gyms.any((g) => g.id == selectedGym)) {
                  selectedGym = null;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Select Gym",
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textFieldNameColor,
                    ),
                    Gap(4.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.backRoudnColors,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.hintTextColors),
                      ),
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        value: selectedGym,
                        hint: CustomText(
                          text: "Select Gym",
                          fontSize: 14.sp,
                          color: AppColors.hintTextColors,
                        ),
                        items: gyms
                            .map((gym) => DropdownMenuItem<String>(
                                  value: gym.id,
                                  child: CustomText(
                                    text: gym.name ?? '',
                                    fontSize: 14.sp,
                                    color: AppColors.mainTextColors,
                                  ),
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            selectedGym = val;
                          });
                          print("Selected Gym ID: $val");
                        },
                      ),
                    ),
                  ],
                );
              }),

              SizedBox(height: 10.h),

              /// Event Type Dropdown
              CustomText(
                  text: "Select Event Type",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textFieldNameColor),
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
                      color: AppColors.hintTextColors),
                  items: _eventTypes
                      .map((event) => DropdownMenuItem<String>(
                            value: event,
                            child: CustomText(
                                text: event,
                                fontSize: 14.sp,
                                color: AppColors.mainTextColors),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => selectedEventType = val),
                ),
              ),

              SizedBox(height: 10.h),

              /// Event Name
              CustomText(
                  text: "Event Name",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textFieldNameColor),
              Gap(4.h),
              CustomTextField(
                  controller: _nameController,
                  hintText: "Enter event name",
                  showObscure: false,
                  fillColor: AppColors.backRoudnColors,
                  hintTextColor: AppColors.hintTextColors,
                  maxLines: 1),

              SizedBox(height: 10.h),

              /// Website Link
              CustomText(
                  text: "Website Link",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textFieldNameColor),
              Gap(4.h),
              CustomTextField(
                  controller: _websiteController,
                  hintText: "Enter website link",
                  showObscure: false,
                  fillColor: AppColors.backRoudnColors,
                  hintTextColor: AppColors.hintTextColors,
                  maxLines: 1),

              SizedBox(height: 10.h),

              /// Registration Fee
              CustomText(
                  text: "Registration Fee",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textFieldNameColor),
              Gap(4.h),
              CustomTextField(
                  controller: _registrationController,
                  hintText: "if registration fee if applicable..",
                  showObscure: false,
                  fillColor: AppColors.backRoudnColors,
                  hintTextColor: AppColors.hintTextColors,
                  maxLines: 1),

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

              /// Date & Time
              CustomText(
                  text: "Date & Time",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mainTextColors),
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
                                  : "${selectedDate!.toLocal()}".split(' ')[0],
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
                                  : selectedTime!.format(context),
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

            Obx(() {
              final isLoading = _addEventController.isLoading.value ||
                  _editEventController.isLoading.value;

              return isLoading
                  ? CustomLoader()
                  : CustomButtonWidget(
                btnColor: AppColors.mainColor,
                btnText: widget.isEdit ? "Update Event" : "Submit",
                onTap: () {
                  if (_nameController.text.isEmpty || selectedDate == null) {
                    CustomToast.showToast(
                      "Event name and date are required",
                      isError: true,
                    );
                    return;
                  }

                  if (selectedGym == null) {
                    CustomToast.showToast("Please select a gym", isError: true);
                    return;
                  }

                  final formattedDate =
                      "${selectedDate!.year.toString().padLeft(4, '0')}-"
                      "${selectedDate!.month.toString().padLeft(2, '0')}-"
                      "${selectedDate!.day.toString().padLeft(2, '0')}";

                  // ✅ Allow edit without new image (use existing one if not changed)
                  final imageFile = selectedImage != null
                      ? File(selectedImage!.path)
                      : null;

                  if (!widget.isEdit) {
                    if (imageFile == null) {
                      CustomToast.showToast("Please select an image", isError: true);
                      return;
                    }

                    _addEventController.addEvent(
                      name: _nameController.text,
                      street: _streetAddressController.text,
                      state: _stateController.text,
                      city: _cityController.text,
                      zipCode: _zipCodeController.text,
                      phone: _phoneController.text,
                      email: _emailController.text,
                      website: _websiteController.text,
                      type: selectedEventType ?? "Seminar",
                      date: formattedDate,
                      registrationFee: _registrationController.text,
                      image: imageFile,
                      gymId: selectedGym.toString(),
                    );
                  } else {
                    
                    
                    print("Selected image $selectedImage");
                    
                    
                    _editEventController.updateEvent(
                      name: _nameController.text,
                      street: _streetAddressController.text,
                      state: _stateController.text,
                      city: _cityController.text,
                      zipCode: _zipCodeController.text,
                      phone: _phoneController.text,
                      email: _emailController.text,
                      website: _websiteController.text,
                      type: selectedEventType ?? "Seminar",
                      date: formattedDate,
                      registrationFee: _registrationController.text,
                      image: imageFile,
                      gymId: selectedGym.toString(),
                      eventId: widget.eventId.toString(),
                    );
                  }
                },
                iconWant: false,
              );
            }),


              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
