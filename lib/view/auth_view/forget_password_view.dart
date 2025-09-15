// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../uitilies/app_colors.dart';
import '../../common widget/custom text/custom_text_widget.dart';
import '../../common widget/custom_app_bar_widget.dart';
import '../../common widget/custom_button_widget.dart';
import 'otp_verify_filed_view.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});

  String? countryCode;
  String? localNumber;

  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Forget Password"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Center(
                child: CustomText(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    text: "Account Verification"),
              ),
              SizedBox(height: 20),

              CustomText(
                text:
                    "We need to send a cod to your current phone number to verify your account.",
                color: Colors.grey,
              ),
              SizedBox(height: 30),
              CustomText(
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.start,
                text: "Phone Number",
              ),

              /// Phone number field
              IntlPhoneField(
                controller: _numberController,
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.outfit(fontSize: 12.h),
                  fillColor: Color(0xFFE4E4E4),
                  filled: true,
                  labelStyle: GoogleFonts.urbanist(fontSize: 13.h),
                  hintText: "Phone Number".tr,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.mainColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.mainColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                initialCountryCode: 'AE',
                onChanged: (phone) {
                  // setState(() {
                  //   countryCode = phone.countryCode;
                  //   localNumber = phone.number;
                  // });
                },
              ),

              SizedBox(height: 10),
              SizedBox(
                height: 55,
                width: double.infinity,
                child: CustomButtonWidget(

                  btnColor: AppColors.mainColor,
                  onTap: () {
                    Get.to(() => OTPVerifyView());
                  },
                  iconWant: false,
                  btnText: 'Verify',
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
