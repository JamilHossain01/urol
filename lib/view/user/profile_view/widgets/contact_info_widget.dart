import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_text_filed.dart';
import '../../../../common widget/phone_number_validator.dart';
import '../../../../uitilies/app_colors.dart';

class ContactInfoWidget extends StatefulWidget {
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController websiteController;
  final TextEditingController facebookController;
  final TextEditingController instagramController;

  const ContactInfoWidget({
    super.key,
    required this.phoneController,
    required this.emailController,
    required this.websiteController,
    required this.facebookController,
    required this.instagramController,
  });

  @override
  State<ContactInfoWidget> createState() => _ContactInfoWidgetState();
}

class _ContactInfoWidgetState extends State<ContactInfoWidget> {
  String? _phoneError;
  String? _websiteError;
  String? _facebookError;
  String? _instagramError;

  void _onPhoneChanged(String value) {
    final formatted = PhoneFormatter.format(value);

    if (formatted != value) {
      widget.phoneController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    setState(() {
      _phoneError = PhoneValidator.validate(formatted);
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? _validateURL(String? value, String fieldName) {
    if (value == null || value.isEmpty) return null; // optional
    final pattern = r'^(https?:\/\/)?' // optional http/https
        r'([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}' // domain
        r'(\/[^\s]*)?$'; // optional path
    if (!RegExp(pattern).hasMatch(value)) {
      return "Enter a valid $fieldName URL";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Contact Information",
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.mainTextColors,
        ),
        SizedBox(height: 12.h),
        // Phone
        CustomText(
            text: "Phone Number",
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textFieldNameColor),
        Gap(4.h),
        CustomTextField(
          controller: widget.phoneController,
          hintText: "Enter your phone number",
          showObscure: false,
          keyboardType: TextInputType.phone,
          errorText: _phoneError,
          onChanged: _onPhoneChanged,
        ),
        SizedBox(height: 12.h),
        // Email
        CustomText(
            text: "Email",
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textFieldNameColor),
        Gap(4.h),
        CustomTextField(
          controller: widget.emailController,
          hintText: "Enter your email address",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
          validator: _validateEmail,
        ),
        SizedBox(height: 12.h),
        // Website
        CustomText(
            text: "Website",
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textFieldNameColor),
        Gap(4.h),
        CustomTextField(
          controller: widget.websiteController,
          hintText: "Enter your website link",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
          errorText: _websiteError,
          onChanged: (val) {
            setState(() {
              _websiteError = _validateURL(val, "website");
            });
          },
        ),
        SizedBox(height: 12.h),
        // Facebook
        CustomText(
            text: "Facebook",
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textFieldNameColor),
        Gap(4.h),
        CustomTextField(
          controller: widget.facebookController,
          hintText: "Enter your Facebook link",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
          errorText: _facebookError,
          onChanged: (val) {
            setState(() {
              _facebookError = _validateURL(val, "Facebook");
            });
          },
        ),
        SizedBox(height: 12.h),
        // Instagram
        CustomText(
            text: "Instagram",
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textFieldNameColor),
        Gap(4.h),
        CustomTextField(
          controller: widget.instagramController,
          hintText: "Enter your Instagram link",
          showObscure: false,
          fillColor: AppColors.backRoudnColors,
          hintTextColor: AppColors.hintTextColors,
          errorText: _instagramError,
          onChanged: (val) {
            setState(() {
              _instagramError = _validateURL(val, "Instagram");
            });
          },
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
