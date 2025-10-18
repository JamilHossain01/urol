import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../uitilies/app_colors.dart';

class AddCompetitionResultScreen extends StatefulWidget {
  const AddCompetitionResultScreen({super.key});

  @override
  State<AddCompetitionResultScreen> createState() =>
      _AddCompetitionResultScreenState();
}

class _AddCompetitionResultScreenState
    extends State<AddCompetitionResultScreen> {
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _streetAddressController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

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
            "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: CustomAppBar(
        title: "Add Competition Result",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: "Competition Details",
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black),
            SizedBox(height: 14.h),
            _buildTextField("Event Name", "Enter the event name", false),
            SizedBox(height: 14.h),
            _buildDatePicker("Event Date", "Select Event Date"),
            SizedBox(height: 14.h),
            _buildDropdown("Division",
                ["Gi", "NoGi", "Gi Absolute", "NoGi Absolute"], "Gi"),
            SizedBox(height: 14.h),
            _buildLocationSection(),
            SizedBox(height: 12.h),
            _buildResultDropdown(),
            SizedBox(height: 24.h),
            CustomButtonWidget(
              btnText: 'Save',
              onTap: () {},
              iconWant: false,
              btnColor: AppColors.mainColor,
            ),
          ],
        ),
      ),
    );
  }

  // Method for creating common text field
  Widget _buildTextField(String label, String hintText, bool obscure) {
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
          hintText: hintText,
          showObscure: obscure,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
        ),
      ],
    );
  }

  // Method for Date Picker
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
            suffixIcon: const Icon(Icons.calendar_today),
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
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Color(0xFFB9B9B9), width: 1),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Color(0xFFB9B9B9)),
            ),
          ),
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }

  // Method for Dropdown
  Widget _buildDropdown(String label, List<String> items, String value) {
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
                  .map((rank) => DropdownMenuItem(

                        value: rank,
                        child: Text(rank, style: TextStyle(fontSize: 13.sp)),
                      ))
                  .toList(),
              onChanged: (newValue) {},
            ),
          ),
        ),
      ],
    );
  }

  // Method for Location Section
  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Location",
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.mainTextColors,
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildTextField("State", "Enter State", false),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildTextField("City", "Enter City", false),
            ),
          ],
        ),
      ],
    );
  }

  // Method for Result Dropdown
  Widget _buildResultDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Result",
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
              border: Border.all(color: Color(0xFFB9B9B9))),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: "Gold",
              items: ["Gold", "Silver", "Bronze", "DNP"]
                  .map((rank) => DropdownMenuItem(
                        value: rank,
                        child: Text(rank, style: TextStyle(fontSize: 13.sp)),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
          ),
        ),
      ],
    );
  }
}
