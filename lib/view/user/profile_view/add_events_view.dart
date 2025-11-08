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
  void initState() {
    // TODO: implement initState
    super.initState();
    _myGymController.getMyGyms();
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

              ImageUploadWidget(
                selectedImage: selectedImage,
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

              /// Replace _gyms list with controller's gyms
              Obx(
                () => Column(
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
                        items: _myGymController.gums.value.data
                            ?.map((gym) => DropdownMenuItem<String>(
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
                ),
              ),
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

              /// Event Name
              CustomText(
                  text: "Website Link",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textFieldNameColor),
              Gap(4.h),
              CustomTextField(
                  controller: _websiteController,
                  hintText: "Enter website or ticket link",
                  showObscure: false,
                  fillColor: AppColors.backRoudnColors,
                  hintTextColor: AppColors.hintTextColors,
                  maxLines: 1),

              SizedBox(height: 10.h),




              /// Event Name
              CustomText(
                  text: "Registration Fee",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textFieldNameColor),
              Gap(4.h),
              CustomTextField(
                  controller: _registrationController,
                  hintText: "if registration fee available provide here..",
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
                return _addEventController.isLoading.value
                    ? CustomLoader()
                    : CustomButtonWidget(
                        btnColor: AppColors.mainColor,
                        btnText: "Submit",
                        onTap: () {
                          if (_nameController.text.isEmpty ||
                              selectedDate == null) {
                            CustomToast.showToast(
                                "Event name, date, and time are required",
                                isError: true);
                            return;
                          }

                          if (selectedImage == null) {
                            CustomToast.showToast("Please select an image",
                                isError: true);
                            return;
                          }

                          if (selectedGym == null) {
                            CustomToast.showToast("Please select a gym",
                                isError: true);
                            return;
                          }

                          // Format date as YYYY-MM-DD
                          final formattedDate =
                              "${selectedDate!.year.toString().padLeft(4, '0')}-"
                              "${selectedDate!.month.toString().padLeft(2, '0')}-"
                              "${selectedDate!.day.toString().padLeft(2, '0')}";


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
                            image: File(selectedImage!.path),
                            gymId: selectedGym.toString(),
                          );
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
