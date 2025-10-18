import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../common widget/dot_border_container.dart';
import '../../../uitilies/app_colors.dart';
import 'widgets/basic_info_widget.dart';
import 'widgets/contact_info_widget.dart';
import 'widgets/disciplines_widget.dart';
import 'widgets/image_upload_widget.dart';
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
  String? _selectedDay;
  String? _startTime;
  String? _endTime;
  final List<String> _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
  final List<String> _times = ['12:30 PM', '1:00 PM', '2:30 PM', '3:00 PM'];

  List<String> _selectedDisciplines = [];

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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final gymData = {
        'gymName': _gymNameController.text,
        'description': _descriptionController.text,
        'streetAddress': _streetAddressController.text,
        'city': _cityController.text,
        'state': _stateController.text,
        'zipCode': _zipCodeController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'website': _websiteController.text,
        'facebook': _facebookController.text,
        'instagram': _instagramController.text,
        'schedule': {
          'day': _selectedDay,
          'startTime': _startTime,
          'endTime': _endTime
        },
        'disciplines': _selectedDisciplines,
      };
      print('Gym Data: $gymData');
      // Add API call or data persistence logic here
      // Example: await ApiService.updateGym(gymData);
    }
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
              ImageUploadWidget(),
              Gap(8.h),
              BasicInfoWidget(
                gymNameController: _gymNameController,
                descriptionController: _descriptionController,
              ),
              LocationWidget(
                streetAddressController: _streetAddressController,
                cityController: _cityController,
                stateController: _stateController,
                zipCodeController: _zipCodeController,
              ),
              ContactInfoWidget(
                phoneController: _phoneController,
                emailController: _emailController,
                websiteController: _websiteController,
                facebookController: _facebookController,
                instagramController: _instagramController,
              ),
              OpenMatScheduleWidget(
                addCC: 'Add More Days',
                selectedDay: _selectedDay,
                startTime: _startTime,
                endTime: _endTime,
                days: _days,
                times: _times,
                onDayChanged: (value) => setState(() => _selectedDay = value),
                onStartTimeChanged: (value) =>
                    setState(() => _startTime = value),
                onEndTimeChanged: (value) => setState(() => _endTime = value),
                onAddMoreDays: () {
                  // Implement logic to add more schedules
                  print("Add More Days tapped");
                },
              ),
              OpenMatScheduleWidget(
                showClassField: true,
                selectedDay: _selectedDay,
                startTime: _startTime,
                endTime: _endTime,
                days: _days,
                times: _times,
                onDayChanged: (value) => setState(() => _selectedDay = value),
                onStartTimeChanged: (value) =>
                    setState(() => _startTime = value),
                onEndTimeChanged: (value) => setState(() => _endTime = value),
                onAddMoreDays: () {
                  // Implement logic to add more schedules
                  print("Add More Days tapped");
                },
              ),

              DisciplinesWidget(
                selectedDisciplines: _selectedDisciplines,
                onSelectionChanged: (disciplines) {
                  setState(() {
                    _selectedDisciplines = disciplines;
                  });
                },
              ),
              SizedBox(height: 20.h),
              CustomButtonWidget(
                btnText: 'Save',
                onTap: _submitForm,
                iconWant: false,
                btnColor: AppColors.mainColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
