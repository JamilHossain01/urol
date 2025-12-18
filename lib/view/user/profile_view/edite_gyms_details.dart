import 'dart:io';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/add_class_schedule_widget.dart';
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
import '../location_view/widgets/upload_card.dart';
import 'controller/edit_gym_controller.dart';
import 'widgets/basic_info_widget.dart';
import 'widgets/contact_info_widget.dart';
import 'widgets/disciplines_widget.dart';
import 'widgets/location_widget.dart';
import 'widgets/open_mat_schedule_widget.dart';

class EditGymView extends StatefulWidget {
  final String? address;
  final dynamic lat;
  final dynamic long;
  final String? state;
  final String? city;
  final String gymId;
  final String gymName;
  final String gymDescription;
  final String gymStreetAddress;
  final String gymCity;
  final String gymState;
  final String gymZipCode;
  final String gymPhone;
  final String gymEmail;
  final String gymWebsite;
  final String gymFacebook;
  final String gymInstagram;
  final String gymClassName;
  final List<String>? gymImages;
  final List<String>? gymDisciplines;
  final List<Map<String, dynamic>>? gymOpenMatSchedules;
  final List<Map<String, dynamic>>? gymClassSchedules;

  EditGymView({
    super.key,
    this.address,
    this.lat,
    this.long,
    this.state,
    this.city,
    required this.gymId,
    required this.gymName,
    required this.gymDescription,
    required this.gymStreetAddress,
    required this.gymCity,
    required this.gymState,
    required this.gymZipCode,
    required this.gymPhone,
    required this.gymEmail,
    required this.gymWebsite,
    required this.gymFacebook,
    required this.gymInstagram,
    required this.gymClassName,
    this.gymImages,
    this.gymDisciplines,
    this.gymOpenMatSchedules,
    this.gymClassSchedules,
  });

  @override
  _EditGymViewState createState() => _EditGymViewState();
}

class _EditGymViewState extends State<EditGymView> {
  final _formKey = GlobalKey<FormState>();
  final _editGymController = Get.put(EditGymController());

  List<String> _existingImageUrls = [];
  List<File> _selectedImages = [];
  List<String> _selectedDisciplines = [];

  File? utilityBillFile;
  File? businessLicenseFile;
  File? taxDocumentFile;

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

  List<Map<String, String?>> openMatSchedules = [];
  List<Map<String, String?>> classSchedules = [];

  double? _lat;
  double? _long;

  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

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

  @override
  void initState() {
    super.initState();

    _gymNameController.text = widget.gymName;
    _descriptionController.text = widget.gymDescription;
    _streetAddressController.text = widget.gymStreetAddress;
    _cityController.text = widget.gymCity;
    _stateController.text = widget.gymState;
    _zipCodeController.text = widget.gymZipCode;
    _phoneController.text = widget.gymPhone;
    _emailController.text = widget.gymEmail;
    _websiteController.text = widget.gymWebsite;
    _facebookController.text = widget.gymFacebook;
    _instagramController.text = widget.gymInstagram;
    _classNameController.text = widget.gymClassName;

    _lat = widget.lat;
    _long = widget.long;

    _selectedDisciplines = List<String>.from(widget.gymDisciplines ?? []);
    _existingImageUrls = widget.gymImages ?? [];

    // Initialize schedules as Strings
    openMatSchedules = widget.gymOpenMatSchedules != null &&
            widget.gymOpenMatSchedules!.isNotEmpty
        ? widget.gymOpenMatSchedules!
            .map((s) => {
                  'day': s['day']?.toString(),
                  'from': s['from']?.toString(),
                  'to': s['to']?.toString(),
                })
            .toList()
        : [
            {'day': null, 'from': null, 'to': null}
          ];

    classSchedules =
        widget.gymClassSchedules != null && widget.gymClassSchedules!.isNotEmpty
            ? widget.gymClassSchedules!
                .map((s) => <String, String?>{
                      'day': s['day']?.toString(),
                      'name': s['name']?.toString() ?? widget.gymClassName,
                      'from': s['from']?.toString(),
                      'to': s['to']?.toString(),
                    })
                .toList()
            : [
                {
                  'day': null,
                  'name': widget.gymClassName,
                  'from': null,
                  'to': null
                }
              ];
  }

  int? convertTimeStringToMinutes(dynamic time) {
    if (time == null) return null;

    // If it's already an int, just return it
    if (time is int) return time;

    // If it's numeric string like "870"
    if (time is String && int.tryParse(time) != null) {
      return int.parse(time);
    }

    if (time is String && time.contains(' ')) {
      try {
        final parts = time.split(' ');
        if (parts.length != 2) return null;

        final hm = parts[0].split(':');
        if (hm.length != 2) return null;

        int hour = int.parse(hm[0]);
        int minute = int.parse(hm[1]);
        String period = parts[1];

        if (period == 'PM' && hour != 12) hour += 12;
        if (period == 'AM' && hour == 12) hour = 0;

        return hour * 60 + minute;
      } catch (e) {
        return null;
      }
    }

    return null;
  }

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images.map((e) => File(e.path)).toList());
      });
    }
  }

  Future<void> _submitGym() async {
    final List<Map<String, dynamic>> openMatConverted = openMatSchedules
        .map((s) => {
              'day': s['day'],
              'from': convertTimeStringToMinutes(s['from']),
              'to': convertTimeStringToMinutes(s['to']),
            })
        .toList();

    final List<Map<String, dynamic>> classConverted = classSchedules
        .map((s) => {
              'name': s['name'],
              'day': s['day'],
              'from': convertTimeStringToMinutes(s['from']),
              'to': convertTimeStringToMinutes(s['to']),
            })
        .toList();

    await _editGymController.editGym(
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
      gymId: widget.gymId,
      newImages: _selectedImages,
      existingImages: _existingImageUrls,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: const CustomAppBar(title: "Edit Gym", showLeadingIcon: true),
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
                          color: AppColors.mainTextColors),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
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
                          ..._existingImageUrls.map((url) => Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(url,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _existingImageUrls.remove(url);
                                        });
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Colors.black54,
                                            shape: BoxShape.circle),
                                        child: const Icon(Icons.close,
                                            size: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
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
                                            shape: BoxShape.circle),
                                        child: const Icon(Icons.close,
                                            size: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),

                      Gap(10.h),
                      BasicInfoWidget(
                          gymNameController: _gymNameController,
                          descriptionController: _descriptionController),

                      CustomText(
                        text: "Required Documents",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textFieldNameColor,
                      ),
                      CustomText(
                        text:
                            "Upload one of these documents to verify ownership.",
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF989898),
                      ),
                      SizedBox(height: 14.h),
                      UploadCard(
                        title: 'Utility Bill',
                        onFileSelected: (file) {
                          setState(() => utilityBillFile = file);
                        },
                      ),
                      SizedBox(height: 6.h),
                      UploadCard(
                        title: 'Business License',
                        onFileSelected: (file) {
                          setState(() => businessLicenseFile = file);
                        },
                      ),
                      SizedBox(height: 6.h),
                      UploadCard(
                        title: 'Tax Document',
                        onFileSelected: (file) {
                          setState(() => taxDocumentFile = file);
                        },
                      ),
                      SizedBox(height: 20.h),

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
                      if (classSchedules.isNotEmpty)
                        Column(
                          children: [
                            // Class Schedule Widget
                            ClassScheduleWidget(
                              days: _days,
                              times: _times,
                              onScheduleAdded: (schedule) {
                                setState(() {
                                  classSchedules.add({
                                    'name': schedule.className,
                                    'day': schedule.day,
                                    'from': schedule.startTime,
                                    'to': schedule.endTime,
                                  });
                                });
                              },
                            ),

                            // Display schedules only if list is not empty
                            if (classSchedules.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    classSchedules.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final c = entry.value;

                                  // Safety check to avoid null
                                  if (c['name'] == null ||
                                      c['day'] == null ||
                                      c['from'] == null ||
                                      c['to'] == null) {
                                    return const SizedBox(); // Skip rendering null items
                                  }

                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.h),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${c['name']} - ${c['day']} (${c['from']} to ${c['to']})",
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.red, size: 20.sp),
                                          onPressed: () {
                                            setState(() {
                                              classSchedules.removeAt(index);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                          ],
                        ),

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
                          btnText: 'Edit Gym',
                          onTap: _submitGym,
                          iconWant: false,
                          btnColor: AppColors.mainColor),
                      Gap(20.h),
                    ],
                  ),
                ),
              ),
              if (_editGymController.isLoading.value)
                Container(
                    color: Colors.black26,
                    child: Center(child: CustomLoader())),
            ],
          )),
    );
  }
}
