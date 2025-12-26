// ignore_for_file: prefer_const_constructors

import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:calebshirthum/view/auth_view/controller/sign_up_controller.dart';
import 'package:calebshirthum/view/auth_view/signUpOtp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../uitilies/app_colors.dart';
import '../../common widget/custom text/custom_text_widget.dart';
import '../../common widget/custom_app_bar_widget.dart';
import '../../common widget/custom_button_widget.dart';
import '../../common widget/custom_text_filed.dart';
import '../../common widget/phone_number_validator.dart';
import 'login_auth_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final SignUpController _signUpController = Get.put(SignUpController());

  /// 🔒 Password Strength Validation Function
  bool _isStrongPassword(String password) {
    return password.length >= 8;
  }

  /// ✅ Validation before signup
  void _validateAndSubmit() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _numberController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      CustomToast.showToast("All fields are required", isError: true);
      return;
    }

    if (!email.contains('@') || !email.contains('.com')) {
      CustomToast.showToast("Please enter a valid email address",
          isError: true);
      return;
    }

    if (!_isStrongPassword(password)) {
      CustomToast.showToast(
        "Password at least 8 chars",
        isError: true,
      );
      return;
    }

    if (password != confirmPassword) {
      CustomToast.showToast("Passwords do not match", isError: true);
      return;
    }

    _signUpController.signUp(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      phoneNumber: _numberController.text.trim(),
      password: _passwordController.text.trim(),
    );
  }

  String? _errorText;

  void _onPhoneChanged(String value) {
    final formatted = PhoneFormatter.format(value);

    if (formatted != value) {
      _numberController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    setState(() {
      _errorText = PhoneValidator.validate(formatted);
    });
  }



  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Create Account"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(15.h),
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Sign up",
                fontSize: 32.sp,
                color: Color(0xFF1E1E1E),
              ),
              Gap(5.h),
              CustomText(
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.start,
                fontSize: 12.sp,
                color: Color(0xFF8A8A8A),
                text: "Create an account to continue",
              ),
              SizedBox(height: 20),

              // First Name
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "First Name",
                color: AppColors.textFieldNameColor,
                fontSize: 12.sp,
              ),
              CustomTextField(
                controller: _firstNameController,
                hintText: "Enter first name",
                showObscure: false,
              ),
              SizedBox(height: 10),

              // Last Name
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Last Name",
                color: AppColors.textFieldNameColor,
                fontSize: 12.sp,
              ),
              CustomTextField(
                controller: _lastNameController,
                hintText: "Enter last name",
                showObscure: false,
              ),
              SizedBox(height: 10),

              // Email
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Email",
                color: AppColors.textFieldNameColor,
                fontSize: 12.sp,
              ),
              CustomTextField(
                controller: _emailController,
                hintText: "Enter your email address",
                showObscure: false,
                fillColor: AppColors.backRoudnColors,
                hintTextColor: AppColors.hintTextColors,
                validator: _validateEmail,
              ),
              SizedBox(height: 10),

              // Phone Number
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Phone Number",
                color: AppColors.textFieldNameColor,
                fontSize: 12.sp,
              ),
              CustomTextField(
                controller: _numberController,
                hintText: "Enter your phone number",
                showObscure: false,
                keyboardType: TextInputType.phone,
                errorText: _errorText,
                onChanged: _onPhoneChanged, // realtime validation
              ),

              SizedBox(height: 10),

              // Password
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Password",
                color: AppColors.textFieldNameColor,
                fontSize: 12.sp,
              ),
              CustomTextField(
                controller: _passwordController,
                hintText: "Enter your password",
                showObscure: true,
              ),
              SizedBox(height: 10),

              // Confirm Password
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Confirm Password",
                color: AppColors.textFieldNameColor,
                fontSize: 12.sp,
              ),
              CustomTextField(
                controller: _confirmPasswordController,
                hintText: "Confirm your password",
                showObscure: true,
              ),
              SizedBox(height: 20),

              Obx(() {
                return _signUpController.isLoading.value == true
                    ? CustomLoader()
                    : SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: CustomButtonWidget(
                          btnColor: AppColors.mainColor,
                          onTap: _validateAndSubmit,
                          iconWant: false,
                          btnText: 'Sign Up',
                        ),
                      );
              }),

              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Already have an account?",
                    color: AppColors.textFieldNameColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => SignInView());
                    },
                    child: CustomText(
                      text: "Login",
                      fontWeight: FontWeight.bold,
                      color: AppColors.mainColor,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
