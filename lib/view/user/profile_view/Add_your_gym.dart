import 'dart:io';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/dot_border_container.dart';
import 'widgets/basic_info_widget.dart';
import 'widgets/contact_info_widget.dart';
import 'widgets/disciplines_widget.dart';
import 'widgets/location_widget.dart';
import 'widgets/open_mat_schedule_widget.dart';

class AddYourGymDetailsScreen extends StatefulWidget {
  const AddYourGymDetailsScreen({super.key});

  @override
  _AddYourGymDetailsScreenState createState() =>
      _AddYourGymDetailsScreenState();
}

class _AddYourGymDetailsScreenState extends State<AddYourGymDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

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
  final _instagramController = TextEditingController();

  List<File> _selectedImages = [];

  final List<String> _days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  final List<String> _times = ['12:30 PM', '1:00 PM', '2:30 PM', '3:00 PM'];

  List<Map<String, String?>> openMatSchedules = [
    {'day': null, 'start': null, 'end': null}
  ];

  List<Map<String, String?>> classSchedules = [
    {'day': null, 'start': null, 'end': null}
  ];

  List<String> _selectedDisciplines = [];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(images.map((e) => File(e.path)).toList());
      });
    }
  }

  @override
  void dispose() {
    _gymNameController.dispose();
    _descriptionController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: CustomAppBar(
        title: "Add Gym",
        showLeadingIcon: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Upload Images",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mainTextColors,
              ),

              SizedBox(height: 10),

              /// Image picker section
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
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.close, size: 16, color: Colors.white),
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

              Gap(8.h),

              /// Basic info
              BasicInfoWidget(
                gymNameController: _gymNameController,
                descriptionController: _descriptionController,
              ),

              /// Location
              LocationWidget(
                streetAddressController: _streetAddressController,
                cityController: _cityController,
                stateController: _stateController,
                zipCodeController: _zipCodeController,
              ),

              /// Contact info
              ContactInfoWidget(
                phoneController: _phoneController,
                emailController: _emailController,
                websiteController: _websiteController,
                facebookController: _facebookController,
                instagramController: _instagramController,
              ),

              /// Dynamic Open Mat Schedule section
              ...openMatSchedules.asMap().entries.map((entry) {
                int index = entry.key;
                var item = entry.value;

                return OpenMatScheduleWidget(
                  addCC: index == openMatSchedules.length - 1
                      ? 'Add More Days'
                      : null,
                  selectedDay: item['day'],
                  startTime: item['start'],
                  endTime: item['end'],
                  days: _days,
                  times: _times,
                  onDayChanged: (value) {
                    setState(() => openMatSchedules[index]['day'] = value);
                  },
                  onStartTimeChanged: (value) {
                    setState(() => openMatSchedules[index]['start'] = value);
                  },
                  onEndTimeChanged: (value) {
                    setState(() => openMatSchedules[index]['end'] = value);
                  },
                  onAddMoreDays: () {
                    setState(() {
                      openMatSchedules
                          .add({'day': null, 'start': null, 'end': null});
                    });
                  },
                  onRemove: openMatSchedules.length > 1
                      ? () {
                          setState(() {
                            openMatSchedules.removeAt(index);
                          });
                        }
                      : null,
                );
              }),

              /// dynamic class schedule section
              ...classSchedules.asMap().entries.map((entry) {
                int index = entry.key;
                var item = entry.value;

                return OpenMatScheduleWidget(
                  showClassField: true,
                  addCC: index == classSchedules.length - 1
                      ? 'Add More Classes'
                      : null,
                  selectedDay: item['day'],
                  startTime: item['start'],
                  endTime: item['end'],
                  days: _days,
                  times: _times,
                  name: item['name'],
                  onDayChanged: (value) =>
                      setState(() => classSchedules[index]['day'] = value),
                  onStartTimeChanged: (value) =>
                      setState(() => classSchedules[index]['start'] = value),
                  onEndTimeChanged: (value) =>
                      setState(() => classSchedules[index]['end'] = value),
                  onAddMoreDays: () => setState(() => classSchedules.add(
                      {'day': null, 'start': null, 'end': null, 'name': null})),
                  onRemove: classSchedules.length > 1
                      ? () => setState(() => classSchedules.removeAt(index))
                      : null,
                );
              }),

              /// Disciplines
              DisciplinesWidget(
                selectedDisciplines: _selectedDisciplines,
                onSelectionChanged: (disciplines) {
                  setState(() {
                    _selectedDisciplines = disciplines;
                  });
                },
              ),

              /// Save Button
              CustomButtonWidget(
                btnText: 'Save',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    debugPrint("Form Valid — Ready to Submit");
                    debugPrint("Schedules: $openMatSchedules");
                  }
                },
                iconWant: false,
                btnColor: AppColors.mainColor,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
