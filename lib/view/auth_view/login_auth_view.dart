// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:calebshirthum/view/auth_view/controller/social_auth_service.dart';
import 'package:calebshirthum/view/auth_view/sign_up_view.dart';
import 'package:calebshirthum/view/auth_view/widget/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../uitilies/app_colors.dart';
import '../../common widget/custom text/custom_text_widget.dart';
import '../../common widget/custom_app_bar_widget.dart';
import '../../common widget/custom_button_widget.dart';
import '../../common widget/custom_text_filed.dart';
import '../user/dashboard_view/enable_location_view.dart';
import 'controller/login_controller.dart';
import 'forget_password_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final LoginController loginController = Get.put(LoginController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _authService = Get.put(AuthService());

  bool _keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showLeadingIcon: false, title: ''),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),

                      // Title
                      CustomText(
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.start,
                        text: "Sign in to your",
                        fontSize: 34.sp,
                        color: Color(0xFF1E1E1E),
                      ),
                      CustomText(
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.start,
                        text: "account",
                        fontSize: 32.sp,
                        color: Color(0xFF1E1E1E),
                      ),
                      CustomText(
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.start,
                        fontSize: 12.sp,
                        color: Color(0xFF8A8A8A),
                        text:
                            "Enter your email address and password to log in ",
                      ),
                      SizedBox(height: 30),

                      // Email
                      CustomText(
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.start,
                        text: "Email",
                        color: AppColors.textFieldNameColor,
                        fontSize: 12.sp,
                      ),
                      CustomTextField(
                        controller: emailController,
                        fillColor: Color(0xFFFFFFFF),
                        hintText: "Enter your email address",
                        showObscure: false,
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
                        controller: passwordController,
                        hintText: "Enter your password",
                        showObscure: true,
                      ),
                      SizedBox(height: 10),

                      // Keep me logged in + Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Theme(
                                data: Theme.of(context).copyWith(
                                  checkboxTheme: CheckboxThemeData(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side: BorderSide(
                                          color: AppColors.mainColor),
                                    ),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,
                                  ),
                                ),
                                child: Checkbox(
                                  value: _keepMeLoggedIn,
                                  onChanged: (value) {
                                    setState(() {
                                      _keepMeLoggedIn = value ?? false;
                                    });
                                  },
                                  side: BorderSide(color: AppColors.mainColor),
                                  activeColor: AppColors.mainColor,
                                ),
                              ),
                              const SizedBox(width: 4),
                              CustomText(
                                text: "Keep me logged in",
                                fontSize: 16,
                                color: const Color(0xFF686868),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => ForgetPasswordView());
                            },
                            child: CustomText(
                              color: AppColors.mainColor,
                              text: "Forgot Password?",
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),

                      // Login Button
                      Obx(() {
                        return loginController.isLoading.value
                            ? Center(child: CustomLoader())
                            : SizedBox(
                                height: 55,
                                width: double.infinity,
                                child: CustomButtonWidget(
                                  btnColor: AppColors.mainColor,
                                  onTap: () {
                                    final email = emailController.text.trim();
                                    final password =
                                        passwordController.text.trim();

                                    // Basic validation
                                    if (email.isEmpty || password.isEmpty) {
                                      CustomToast.showToast(
                                        "All fields are required",
                                        isError: true,
                                      );
                                    } else if (!email.contains('@') ||
                                        !email.contains('.com')) {
                                      CustomToast.showToast(
                                        "Please enter a valid email address",
                                        isError: true,
                                      );
                                    } else {
                                      loginController.login(
                                        email: email,
                                        password: password,
                                      );
                                    }
                                  },
                                  iconWant: false,
                                  btnText: 'Log In',
                                ),
                              );
                      }),
                      SizedBox(height: 20),

                      // Or Continue With
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              color: Colors.grey, width: 160, height: 1.5),
                          CustomText(text: "Or"),
                          Container(
                              color: Colors.grey, width: 160, height: 1.5),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Google + Apple Sign-in buttons
                      SocialLoginButtons(
                        onGoogleTap: () {
                          print("Google login tapped");
                          _authService.signInWithGoogle();
                        },
                        onAppleTap: () {
                          print("Apple login tapped");
                          // TODO: Add Apple login logic here
                        },
                      ),
                      SizedBox(height: 20),

                      // Don't have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Don’t have an account?",
                            color: AppColors.pTextColors,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SignUpView());
                            },
                            child: CustomText(
                              text: "Sign Up",
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
