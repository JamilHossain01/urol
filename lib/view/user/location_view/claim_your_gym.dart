// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';
import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/view/user/location_view/widgets/upload_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_button_widget.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../common widget/phone_number_validator.dart';
import '../../../uitilies/app_colors.dart';
import '../../../uitilies/custom_toast.dart';
import '../profile_view/widgets/location_widget.dart';
import 'controller/claim_your_gym_controller.dart';

class ClaimYourGymScreen extends StatefulWidget {
  final String gymId;

  const ClaimYourGymScreen({super.key, required this.gymId});

  @override
  State<ClaimYourGymScreen> createState() => _ClaimYourGymScreenState();
}

class _ClaimYourGymScreenState extends State<ClaimYourGymScreen> {
  double? _lat;
  double? _long;

  final TextEditingController _streetAddressController =
      TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  final ClaimYourGymController _claimYourGymController =
      Get.put(ClaimYourGymController());

  File? utilityBillFile;
  File? businessLicenseFile;
  File? taxDocumentFile;

  String? _errorText;

  void _onPhoneChanged(String value) {
    final formatted = PhoneFormatter.format(value);

    if (formatted != value) {
      _phoneController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    setState(() {
      _errorText = PhoneValidator.validate(formatted);
    });
  }

  @override
  void dispose() {
    _streetAddressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleClaimGym() async {
    if (_emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        utilityBillFile == null ||
        businessLicenseFile == null ||
        taxDocumentFile == null) {
      CustomToast.showToast("All fields and documents are required!",
          isError: true);
      return;
    }

    await _claimYourGymController.claimYourGym(
      utilityBill: utilityBillFile!,
      businessLicense: businessLicenseFile!,
      taxPhoto: taxDocumentFile!,
      email: _emailController.text,
      gymId: widget.gymId,
      phone: _phoneController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: CustomAppBar(
        title: "Claim Your Gym",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Gym Name",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              hintText: "Enter gym name",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 14.h),
            CustomText(
              text: "Email",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              controller: _emailController,
              hintText: "Enter email address",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 14.h),
            CustomText(
              text: "Phone Number",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              controller: _phoneController,
              hintText: "Enter your phone number",
              showObscure: false,
              keyboardType: TextInputType.phone,
              errorText: _errorText,
              onChanged: _onPhoneChanged,
            ),
            SizedBox(height: 14.h),
            CustomText(
              text: "Required Documents",
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            CustomText(
              text: "Upload one of these documents to verify ownership.",
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
            Obx(() {
              return _claimYourGymController.isLoading.value
                  ? CustomLoader()
                  : CustomButtonWidget(
                      btnText: 'Claim Gym',
                      onTap: _handleClaimGym,
                      iconWant: false,
                      btnColor: AppColors.mainColor,
                    );
            }),
          ],
        ),
      ),
    );
  }
}
