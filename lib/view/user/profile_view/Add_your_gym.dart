import 'dart:io';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/dot_border_container.dart';
import '../../../uitilies/custom_loader.dart';
import 'controller/add_gym_controller.dart';
import 'widgets/basic_info_widget.dart';
import 'widgets/contact_info_widget.dart';
import 'widgets/disciplines_widget.dart';
import 'widgets/location_widget.dart';
import 'widgets/open_mat_schedule_widget.dart';

class AddYourGymDetailsScreen extends StatefulWidget {
  final String? address;
  final dynamic lat;
  final dynamic long;
  final String? state;
  final String? city;

  AddYourGymDetailsScreen(
      {super.key, this.address, this.lat, this.long, this.state, this.city});

  @override
  _AddYourGymDetailsScreenState createState() =>
      _AddYourGymDetailsScreenState();
}

class _AddYourGymDetailsScreenState extends State<AddYourGymDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addGymController = Get.put(AddGymController());

  // --- Controllers ---
  final _gymNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();
  final _facebookController = TextEditingController();
  final _classNameController = TextEditingController();
  final _instagramController = TextEditingController();

  // --- Data ---
  List<File> _selectedImages = [];
  List<String> _selectedDisciplines = [];

  List<Map<String, dynamic>> openMatSchedules = [
    {'day': null, 'from': null, 'to': null}
  ];

  List<Map<String, dynamic>> classSchedules = [
    {'day': null, "name": null, 'from': null, 'to': null}
  ];

  double? _lat;
  double? _long;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.address != null) _streetAddressController.text = widget.address!;
    if (widget.city != null) _cityController.text = widget.city!;
    if (widget.state != null) _stateController.text = widget.state!;
    _lat = widget.lat;
    _long = widget.long;
  }

  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  int _convertTimeToMinutes(String time) {
    final parts = time.split(' ');
    final hourMinute = parts[0].split(':');
    int hour = int.parse(hourMinute[0]);
    int minute = int.parse(hourMinute[1]);
    final period = parts[1].toUpperCase();

    if (period == 'PM' && hour != 12) hour += 12;
    if (period == 'AM' && hour == 12) hour = 0;

    return hour * 60 + minute;
  }

  final List<String> _times = [
    '12:00 AM',
    '12:30 AM',
    '1:00 AM',
    '1:30 AM',
    '2:00 AM',
    '2:30 AM',
    '3:00 AM',
    '3:30 AM',
    '4:00 AM',
    '4:30 AM',
    '5:00 AM',
    '5:30 AM',
    '6:00 AM',
    '6:30 AM',
    '7:00 AM',
    '7:30 AM',
    '8:00 AM',
    '8:30 AM',
    '9:00 AM',
    '9:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '12:00 PM',
    '12:30 PM',
    '1:00 PM',
    '1:30 PM',
    '2:00 PM',
    '2:30 PM',
    '3:00 PM',
    '3:30 PM',
    '4:00 PM',
    '4:30 PM',
    '5:00 PM',
    '5:30 PM',
    '6:00 PM',
    '6:30 PM',
    '7:00 PM',
    '7:30 PM',
    '8:00 PM',
    '8:30 PM',
    '9:00 PM',
    '9:30 PM',
    '10:00 PM',
    '10:30 PM',
    '11:00 PM',
    '11:30 PM',
  ];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images.map((e) => File(e.path)).toList());
      });
    }
  }

  // --- Validate schedules ---
  bool _validateSchedules(List<Map<String, dynamic>> schedules) {
    for (var s in schedules) {
      if (s['day'] == null || s['from'] == null || s['to'] == null) {
        return false;
      }
    }
    return true;
  }

  // --- Validate & Submit ---
  Future<void> _submitGym() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedImages.isEmpty) {
      Get.snackbar("Error", "Please upload at least one image",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (_selectedDisciplines.isEmpty) {
      Get.snackbar("Error", "Please select at least one discipline",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (!_validateSchedules(openMatSchedules)) {
      Get.snackbar("Error", "Please fill all open mat schedule fields",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (!_validateSchedules(classSchedules)) {
      Get.snackbar("Error", "Please fill all class schedule fields",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Convert selected times (e.g. "12:30 PM") to total minutes
    final List<Map<String, dynamic>> openMatConverted = openMatSchedules
        .map((s) => {
              'day': s['day'],
              'from': _convertTimeToMinutes(s['from']),
              'to': _convertTimeToMinutes(s['to'])
            })
        .toList();

    final List<Map<String, dynamic>> classConverted = classSchedules
        .map((s) => {
              'name': _classNameController.text,
              'day': s['day'],
              'from': _convertTimeToMinutes(s['from']),
              'to': _convertTimeToMinutes(s['to'])
            })
        .toList();

    await _addGymController.addGym(
      name: _gymNameController.text.trim(),
      description: _descriptionController.text.trim(),
      street: _streetAddressController.text.trim(),
      state: _stateController.text.trim(),
      city: _cityController.text.trim(),
      zipCode: _zipCodeController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      website: _websiteController.text.trim(),
      facebook: _facebookController.text.trim(),
      instagram: _instagramController.text.trim(),
      latitude: _lat,
      longitude: _long,
      disciplines: _selectedDisciplines,
      matSchedules: openMatConverted,
      classSchedules: classConverted,
      images: _selectedImages,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: const CustomAppBar(
        title: "Add Gym",
        showLeadingIcon: true,
      ),
      body: Obx(() => Stack(
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Upload Images",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainTextColors,
                      ),
                      const SizedBox(height: 10),

                      /// Image Picker
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          ..._selectedImages.map((img) => Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: DottedBorderBox(
                                      height: 80,
                                      width: 80,
                                      borderRadius: 10,
                                      borderColor: Colors.grey,
                                      borderWidth: 2,
                                      child: Image.file(img, fit: BoxFit.cover),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedImages.remove(img);
                                        });
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.close,
                                            size: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          GestureDetector(
                            onTap: _pickImages,
                            child: DottedBorderBox(
                              height: 70,
                              width: 130,
                              borderRadius: 10,
                              borderColor: Colors.grey.withOpacity(0.4),
                              borderWidth: 2,
                              icon: Icons.add_a_photo_outlined,
                              iconColor: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Gap(10.h),

                      BasicInfoWidget(
                        gymNameController: _gymNameController,
                        descriptionController: _descriptionController,
                      ),

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

                      ContactInfoWidget(
                        phoneController: _phoneController,
                        emailController: _emailController,
                        websiteController: _websiteController,
                        facebookController: _facebookController,
                        instagramController: _instagramController,
                      ),

                      /// Open Mat Schedule
                      ...openMatSchedules.asMap().entries.map((entry) {
                        int index = entry.key;
                        var item = entry.value;

                        return OpenMatScheduleWidget(
                          addCC: index == openMatSchedules.length - 1
                              ? 'Add More Days'
                              : null,
                          selectedDay: item['day'],
                          startTime: item['from'],
                          endTime: item['to'],
                          days: _days,
                          times: _times,
                          onDayChanged: (value) =>
                              setState(() => item['day'] = value),
                          onStartTimeChanged: (value) =>
                              setState(() => item['from'] = value),
                          onEndTimeChanged: (value) =>
                              setState(() => item['to'] = value),
                          onAddMoreDays: () => setState(() {
                            openMatSchedules
                                .add({'day': null, 'from': null, 'to': null});
                          }),
                          onRemove: openMatSchedules.length > 1
                              ? () => setState(() {
                                    openMatSchedules.removeAt(index);
                                  })
                              : null,
                        );
                      }),

                      /// Class Schedule
                      ...classSchedules.asMap().entries.map((entry) {
                        int index = entry.key;
                        var item = entry.value;

                        return OpenMatScheduleWidget(
                          classNameController: _classNameController,
                          showClassField: true,
                          addCC: index == classSchedules.length - 1
                              ? 'Add More Classes'
                              : null,
                          selectedDay: item['day'],
                          startTime: item['from'],
                          endTime: item['to'],
                          days: _days,
                          times: _times,
                          onDayChanged: (value) =>
                              setState(() => item['day'] = value),
                          onStartTimeChanged: (value) =>
                              setState(() => item['from'] = value),
                          onEndTimeChanged: (value) =>
                              setState(() => item['to'] = value),
                          onAddMoreDays: () => setState(() {
                            classSchedules
                                .add({'day': null, 'from': null, 'to': null});
                          }),
                          onRemove: classSchedules.length > 1
                              ? () => setState(() {
                                    classSchedules.removeAt(index);
                                  })
                              : null,
                        );
                      }),

                      DisciplinesWidget(
                        selectedDisciplines: _selectedDisciplines,
                        onSelectionChanged: (disciplines) {
                          setState(() {
                            _selectedDisciplines = disciplines;
                          });
                        },
                      ),

                      Gap(10.h),

                      CustomButtonWidget(
                        btnText: 'Save',
                        onTap: _submitGym,
                        iconWant: false,
                        btnColor: AppColors.mainColor,
                      ),
                      Gap(20.h),
                    ],
                  ),
                ),
              ),
              if (_addGymController.isLoading.value)
                Container(
                  color: Colors.black26,
                  child: Center(
                    child: CustomLoader(),
                  ),
                ),
            ],
          )),
    );
  }
}
