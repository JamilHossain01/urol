import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/view/user/profile_view/controller/delete_gym_controller.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/add_class_schedule_widget.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/final_location_widget.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/mat_schdule_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/dot_border_container.dart';
import '../../../common widget/format_min_to_hrs_min.dart';
import '../../../uitilies/custom_loader.dart';
import '../location_view/widgets/upload_card.dart';
import 'controller/delete_gym_details_image_controller.dart';
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
  final List<String> gymClassName;
  final List<String>? gymImages;
  final List<String>? imageId;
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
    this.imageId,
  });

  @override
  _EditGymViewState createState() => _EditGymViewState();
}

class _EditGymViewState extends State<EditGymView> {
  final _formKey = GlobalKey<FormState>();
  final _editGymController = Get.put(EditGymController());

  final DeleteGymImageController _deleteGymImageController =
      Get.put(DeleteGymImageController());

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
  final _apprtmentControlller = TextEditingController();

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

    _classNameController.text = '';

    _lat = widget.lat;
    _long = widget.long;

    _selectedDisciplines = List<String>.from(widget.gymDisciplines ?? []);
    _existingImageUrls = widget.gymImages ?? [];

    openMatSchedules = widget.gymOpenMatSchedules != null &&
            widget.gymOpenMatSchedules!.isNotEmpty
        ? widget.gymOpenMatSchedules!
            .map((s) => {
                  'day': s['day']?.toString(),
                  'from': toSafeTime(s['from']),
                  'to': toSafeTime(s['to']),
                })
            .toList()
        : [
            {'day': null, 'from': null, 'to': null}
          ];

    classSchedules =
        widget.gymClassSchedules != null && widget.gymClassSchedules!.isNotEmpty
            ? widget.gymClassSchedules!.asMap().entries.map((entry) {
                final i = entry.key;
                final s = entry.value;

                String? name;
                if (s['name'] != null && s['name'].toString().isNotEmpty) {
                  name = s['name'].toString();
                } else if (i < widget.gymClassName.length) {
                  name = widget.gymClassName[i];
                } else if (widget.gymClassName.isNotEmpty) {
                  name = widget.gymClassName.first;
                } else {
                  name = null;
                }

                return {
                  'day': s['day']?.toString(),
                  'name': name,
                  'from': toSafeTime(s['from']),
                  'to': toSafeTime(s['to']),
                };
              }).toList()
            : widget.gymClassName.isNotEmpty
                ? widget.gymClassName
                    .map((name) => {
                          'day': null,
                          'name': name,
                          'from': null,
                          'to': null,
                        })
                    .toList()
                : [
                    {
                      'day': null,
                      'name': null,
                      'from': null,
                      'to': null,
                    }
                  ];
  }

  int _convertTimeToMinutes(String time) {
    time = time.trim();
    if (time.isEmpty) return 0;

    // Check if AM/PM exists
    if (time.toUpperCase().contains('AM') ||
        time.toUpperCase().contains('PM')) {
      final parts = time.split(' ');
      if (parts.length != 2) return 0;

      final hourMinute = parts[0].split(':');
      if (hourMinute.length != 2) return 0;

      int hour = int.tryParse(hourMinute[0]) ?? 0;
      int minute = int.tryParse(hourMinute[1]) ?? 0;
      final period = parts[1].toUpperCase();

      if (period == 'PM' && hour != 12) hour += 12;
      if (period == 'AM' && hour == 12) hour = 0;

      return hour * 60 + minute;
    } else {
      final hourMinute = time.split(':');
      if (hourMinute.length != 2) return 0;

      int hour = int.tryParse(hourMinute[0]) ?? 0;
      int minute = int.tryParse(hourMinute[1]) ?? 0;

      return hour * 60 + minute;
    }
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
    final openMatConverted = openMatSchedules
        .where((s) => s['day'] != null && s['from'] != null && s['to'] != null)
        .map((s) => {
              'day': s['day'] as String,
              'from': _convertTimeToMinutes(s['from'] as String),
              'to': _convertTimeToMinutes(s['to'] as String),
            })
        .toList();

    final classConverted = classSchedules
        .where((s) =>
            s['name'] != null &&
            s['day'] != null &&
            s['from'] != null &&
            s['to'] != null)
        .map((s) => {
              'name': s['name'] as String,
              'day': s['day'] as String,
              'from': _convertTimeToMinutes(s['from'] as String),
              'to': _convertTimeToMinutes(s['to'] as String),
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
      apartment: _apprtmentControlller.text,
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
                                    child: CachedNetworkImage(
                                      imageUrl: url,
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          CustomLoader(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (_existingImageUrls.contains(url)) {
                                          final imageIdToDelete = widget
                                                  .imageId?[
                                              _existingImageUrls.indexOf(url)];

                                          if (imageIdToDelete != null) {
                                            await _deleteGymImageController
                                                .deleteGymImage(
                                              gymId: widget.gymId,
                                              imageId: imageIdToDelete,
                                            );

                                            setState(() {
                                              _existingImageUrls.remove(url);
                                            });
                                          }
                                        }
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

                      SizedBox(height: 10.h),

                      FinalLocationWidget(
                        apartmentController: _apprtmentControlller,
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
                        stringOfHintText: 'Enter gym address',
                      ),
                      SizedBox(height: 15),
                      ContactInfoWidget(
                        phoneController: _phoneController,
                        emailController: _emailController,
                        websiteController: _websiteController,
                        facebookController: _facebookController,
                        instagramController: _instagramController,
                      ),

                      /// Open Mat Schedule

                      Column(
                        children: [
                          MatScheduleWidgetWidget(
                            days: _days,
                            times: _times,
                            onScheduleAdded: (schedule) {
                              print(
                                  "New Schedule: ${schedule.day} ${schedule.startTime} – ${schedule.endTime}");

                              setState(() {
                                openMatSchedules.add({
                                  'day': schedule.day?.trim(),
                                  'from': schedule.startTime?.trim(),
                                  'to': schedule.endTime?.trim(),
                                });
                              });
                            },
                          ),
                          if (openMatSchedules.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  openMatSchedules.asMap().entries.map((entry) {
                                final index = entry.key;
                                final c = entry.value;

                                if (c['day'] == null ||
                                    c['from'] == null ||
                                    c['to'] == null) {
                                  return const SizedBox();
                                }

                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 6.h),
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Leading icon
                                      Container(
                                        padding: EdgeInsets.all(8.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.schedule,
                                          size: 18.sp,
                                          color: Colors.white,
                                        ),
                                      ),

                                      Gap(12.w),

                                      // Schedule info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Gap(4.h),
                                            Text(
                                              "${c['day']} • ${c['from']} – ${c['to']}",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Delete action
                                      InkWell(
                                        borderRadius: BorderRadius.circular(30),
                                        onTap: () {
                                          setState(() {
                                            openMatSchedules.removeAt(index);
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(6.w),
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: Colors.redAccent,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      /// Class Schedule
                      Column(
                        children: [
                          // Class Schedule Widget
                          ClassScheduleWidget(
                            days: _days,
                            times: _times,
                            onScheduleAdded: (schedule) {
                              print(
                                  "New Schedule: ${schedule.className} ${schedule.day} – ${schedule.endTime}");

                              setState(() {
                                classSchedules.add({
                                  'name': schedule.className?.trim(),
                                  'day': schedule.day?.trim(),
                                  'from': schedule.startTime?.trim(),
                                  'to': schedule.endTime?.trim(),
                                });
                              });
                            },
                          ),

                          if (classSchedules.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  classSchedules.asMap().entries.map((entry) {
                                final index = entry.key;
                                final c = entry.value;

                                if (c['name'] == null ||
                                    c['day'] == null ||
                                    c['from'] == null ||
                                    c['to'] == null) {
                                  return const SizedBox();
                                }

                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 6.h),
                                  padding: EdgeInsets.all(12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Leading icon
                                      Container(
                                        padding: EdgeInsets.all(8.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.schedule,
                                          size: 18.sp,
                                          color: Colors.white,
                                        ),
                                      ),

                                      Gap(12.w),

                                      // Schedule info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${c['name']}",
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            Gap(4.h),
                                            Text(
                                              "${c['day']} • ${c['from']} – ${c['to']}",
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // Delete action
                                      InkWell(
                                        borderRadius: BorderRadius.circular(30),
                                        onTap: () {
                                          setState(() {
                                            classSchedules.removeAt(index);
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(6.w),
                                          child: Icon(
                                            Icons.delete_outline,
                                            color: Colors.redAccent,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                      Gap(5.h),

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
