import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/view/user/profile_view/controller/add_competition_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/custom_toast.dart';

class AddCompetitionResultScreen extends StatefulWidget {
  const AddCompetitionResultScreen({super.key});

  @override
  State<AddCompetitionResultScreen> createState() =>
      _AddCompetitionResultScreenState();
}

class _AddCompetitionResultScreenState
    extends State<AddCompetitionResultScreen> {
  final _eventNameController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String _selectedDivision = "Gi";
  String _selectedResult = "Gold";

  List<String> usaStates = [
    "Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi",
    "Missouri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "New York",
    "North Carolina",
    "North Dakota",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Vermont",
    "Virginia",
    "Washington",
    "West Virginia",
    "Wisconsin",
    "Wyoming"
  ];

  final AddCompetitionController _addCompetitionController =
      Get.put(AddCompetitionController());

  // Function to pick a date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: CustomAppBar(title: "Add Competition Result"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Event Name", "Enter the event name",
                controller: _eventNameController),
            SizedBox(height: 14.h),
            _buildDatePicker("Event Date", "Select Event Date"),
            SizedBox(height: 14.h),
            _buildDropdown(
                "Division",
                ["Gi", "NoGi", "Gi Absolute", "NoGi Absolute"],
                _selectedDivision, (value) {
              setState(() => _selectedDivision = value!);
            }),
            SizedBox(height: 14.h),
            _buildLocationSection(),
            SizedBox(height: 12.h),
            _buildResultDropdown(),
            SizedBox(height: 24.h),
            Obx(() {
              return _addCompetitionController.isLoading.value
                  ? Center(child: CustomLoader())
                  : CustomButtonWidget(
                      btnText: 'Save',
                      onTap: _saveCompetition,
                      iconWant: false,
                      btnColor: AppColors.mainColor,
                    );
            }),
          ],
        ),
      ),
    );
  }

  void _saveCompetition() {
    final eventName = _eventNameController.text.trim();
    final eventDate = _dateController.text.trim();
    final city = _cityController.text.trim();
    final state = _stateController.text.trim();

    if (eventName.isEmpty ||
        eventDate.isEmpty ||
        city.isEmpty ||
        state.isEmpty) {
      CustomToast.showToast("Please fill in all required fields!", isError: true);
      return;
    }

    _addCompetitionController.addCompetition(
      eventName: eventName,
      eventDate: eventDate,
      division: _selectedDivision,
      city: city,
      state: state,
      result: _selectedResult,
    );
  }

  // Common text field
  Widget _buildTextField(String label, String hintText,
      {required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        SizedBox(height: 6.h),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
          showObscure: false,
        ),
      ],
    );
  }

  // Date picker
  Widget _buildDatePicker(String label, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: _dateController,
          readOnly: true,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: Icon(Icons.calendar_today),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Color(0xFFB9B9B9), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Color(0xFFB9B9B9), width: 1),
            ),
          ),
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }

  // Dropdown
  Widget _buildDropdown(String label, List<String> items, String value,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.textFieldNameColor,
        ),
        SizedBox(height: 6.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: AppColors.backRoudnColors,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Color(0xFFB9B9B9)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              items: items
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e, style: TextStyle(fontSize: 13.sp)),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  // Location
  Widget _buildLocationSection() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "State",
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textFieldNameColor,
              ),
              SizedBox(height: 4.h),
              DropdownButtonFormField<String>(
                hint: const Text("Select State"),
                isExpanded: true,
                value: usaStates.contains(_stateController.text)
                    ? _stateController.text
                    : null,
                items: usaStates.map((state) {
                  return DropdownMenuItem(
                    value: state,
                    child: Text(state),
                  );
                }).toList(),
                onChanged: (value) {
                  _stateController.text = value ?? '';
                  setState(() {});
                },
                validator: (value) =>
                    value == null || value.isEmpty ? "State is required" : null,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.backRoudnColors,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.4),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.4),
                      width: 1.5,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildTextField("City", "Enter City",
              controller: _cityController),
        ),
      ],
    );
  }

  // Result dropdown
  Widget _buildResultDropdown() {
    return _buildDropdown(
      "Result",
      ["Gold", "Silver", "Bronze", "DNP"],
      _selectedResult,
      (value) => setState(() => _selectedResult = value!),
    );
  }
}
