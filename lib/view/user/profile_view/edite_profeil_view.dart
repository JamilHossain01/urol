import 'dart:io';

import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../common widget/phone_number_validator.dart';
import '../home_view/controller/my_profile_controller.dart';
import 'controller/update_profile_controller.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GetProfileController _profileCtrl = Get.put(GetProfileController());
  final UpdateProfileController _updateCtrl =
      Get.put(UpdateProfileController());

  // Form Fields
  late TextEditingController _fNameCtrl;
  late TextEditingController _lNameCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _homeGymCtrl;
  late TextEditingController _weightCtrl;
  late TextEditingController _quoteCtrl;

  // Dropdowns & Chips
  String? selectedBelt;
  String? selectedFeet;
  String? selectedInches;
  final Set<String> selectedDisciplines = {};

  // Image
  XFile? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  // Options
  final List<String> beltRanks = [
    "Select One",
    "White",
    "Blue",
    "Purple",
    "Brown",
    "Black"
  ];
  final List<String> feetOptions =
      List.generate(8, (i) => (4 + i).toString()); // "4" to "11"
  final List<String> inchesOptions =
      List.generate(12, (i) => i.toString()); // "0" to "11"
  final List<String> disciplines = [
    "Jiu Jitsu",
    "Wrestling",
    "Judo",
    "MMA",
    "Boxing",
    "Muay Thai",
    "Kickboxing"
  ];

  String? _phoneError;
  void _onPhoneChanged(String value) {
    final formatted = PhoneFormatter.format(value);

    if (formatted != value) {
      _phoneCtrl.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }

    setState(() {
      _phoneError = PhoneValidator.validate(formatted);
    });
  }

  @override
  void initState() {
    super.initState();

    _fNameCtrl = TextEditingController();
    _lNameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _homeGymCtrl = TextEditingController();
    _weightCtrl = TextEditingController();
    _quoteCtrl = TextEditingController();

    ever(_profileCtrl.profile, (_) => _populateFromProfile());
    if (_profileCtrl.profile.value.data != null) {
      _populateFromProfile();
    }
  }

  void _populateFromProfile() {
    final data = _profileCtrl.profile.value.data;
    if (data == null) return;

    setState(() {
      _fNameCtrl.text = "${data.firstName}";
      _lNameCtrl.text = "${data.lastName}";
      _emailCtrl.text = data.email ?? "";
      _phoneCtrl.text = data.contact ?? "";
      _homeGymCtrl.text = data.homeGym ?? "";
      _weightCtrl.text = (data.weight ?? "")
          .replaceAll(RegExp(r'kg|lb', caseSensitive: false), '')
          .trim();
      _quoteCtrl.text = data.favouriteQuote ?? "";

      final belt = data.beltRank?.trim();
      selectedBelt = beltRanks.contains(belt) ? belt : beltRanks[0];

      final cm = data.height?.amount ?? 0;
      if (cm > 0) {
        final totalInches = cm / 2.54;
        final feet = (totalInches ~/ 12).toString();
        final inches = (totalInches % 12).round().toString();

        selectedFeet = _clampFeet(feet);
        selectedInches = inchesOptions.contains(inches) ? inches : "0";
      } else {
        selectedFeet = "5";
        selectedInches = "0";
      }

      selectedDisciplines.clear();
      selectedDisciplines.addAll(data.disciplines);
    });
  }

  String _clampFeet(String feetStr) {
    final feet = int.tryParse(feetStr) ?? 5;
    if (feet < 4) return "4";
    if (feet > 11) return "11";
    return feet.toString();
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _pickedImage = picked);
    }
  }

  Future<void> _saveProfile() async {
    final feet = int.tryParse(selectedFeet ?? "5") ?? 5;
    final inches = int.tryParse(selectedInches ?? "0") ?? 0;
    final heightCm = (feet * 12 + inches) * 2.54;

    await _updateCtrl.updateProfile(
      firstName: _fNameCtrl.text,
      lastName: _lNameCtrl.text,
      contact: _phoneCtrl.text.trim(),
      beltRank: selectedBelt == "Select One" ? "" : selectedBelt!,
      disciplines: selectedDisciplines.toList(),
      favouriteQuote: _quoteCtrl.text.trim(),
      heightCm: heightCm,
      weight: "${_weightCtrl.text.trim()} kg",
      homeGym: _homeGymCtrl.text.trim(),
      profilePicture: _pickedImage != null ? File(_pickedImage!.path) : null,
    );
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _homeGymCtrl.dispose();
    _weightCtrl.dispose();
    _quoteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Edit Profile', showLeadingIcon: true),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          final isLoading = _updateCtrl.isLoading.value;
          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 120.w,
                            height: 120.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.mainColor, width: 4),
                            ),
                            child: CircleAvatar(
                              radius: 56.r,
                              backgroundImage: _getImageProvider(),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                ),
                                child: Icon(Icons.camera_alt,
                                    size: 18.sp, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25.h),

                    _buildLabel("First Name"),
                    CustomTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]')),
                        ],
                        controller: _fNameCtrl,
                        hintText: "Enter first name",
                        showObscure: false),

                    SizedBox(height: 16.h),
                    _buildLabel("Last Name"),
                    CustomTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z]')),
                        ],
                        controller: _lNameCtrl,
                        hintText: "Enter last name",
                        showObscure: false),

                    SizedBox(height: 16.h),

                    _buildLabel("Email"),
                    CustomTextField(
                      readOnly: true,
                      controller: _emailCtrl,
                      hintText: "Enter email",
                      showObscure: false,
                    ),
                    SizedBox(height: 16.h),

                    _buildLabel("Phone Number"),
                    CustomTextField(
                      controller: _phoneCtrl,
                      hintText: "Enter your phone number",
                      showObscure: false,
                      keyboardType: TextInputType.phone,
                      errorText: _phoneError,
                      onChanged: _onPhoneChanged,
                    ),
                    SizedBox(height: 16.h),

                    _buildLabel("Home Gym"),
                    CustomTextField(
                        controller: _homeGymCtrl,
                        hintText: "Enter gym",
                        showObscure: false),
                    SizedBox(height: 16.h),

                    _buildLabel("Belt Rank"),
                    _buildDropdown(selectedBelt ?? beltRanks[0], beltRanks,
                        (v) => setState(() => selectedBelt = v)),
                    SizedBox(height: 16.h),

                    _buildLabel("Disciplines"),
                    SizedBox(height: 6.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children:
                          disciplines.map((d) => _disciplineChip(d)).toList(),
                    ),
                    SizedBox(height: 16.h),

                    _buildLabel("Favorite Quote"),
                    CustomTextField(
                      controller: _quoteCtrl,
                      hintText: "Write your favorite quote...",
                      maxLines: 3,
                      showObscure: false,
                    ),
                    SizedBox(height: 26.h),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r)),
                        ),
                        onPressed: isLoading ? null : _saveProfile,
                        child: isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: CustomLoader())
                            : CustomText(
                                text: "Save",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
              if (isLoading)
                Container(
                    color: Colors.black54,
                    child: Center(child: CustomLoader())),
            ],
          );
        }),
      ),
    );
  }

  ImageProvider _getImageProvider() {
    if (_pickedImage != null) {
      return FileImage(File(_pickedImage!.path));
    }
    final url = _profileCtrl.profile.value.data?.image;
    return url != null && url.isNotEmpty
        ? NetworkImage(url)
        : const NetworkImage(
            "https://static.vecteezy.com/system/resources/previews/013/360/247/non_2x/default-avatar-photo-icon-social-media-profile-sign-symbol-vector.jpg");
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: CustomText(
        text: text,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.mainTextColors,
      ),
    );
  }

  // FIXED: Safe Dropdown
  Widget _buildDropdown(
      String? value, List<String> items, Function(String?) onChanged) {
    final safeValue =
        (value != null && items.contains(value)) ? value : items[0];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: safeValue,
          isExpanded: true,
          items: items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: TextStyle(fontSize: 13.sp)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildHeightDropdown(String label, String? value, List<String> items,
      Function(String?) onChanged) {
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
        _buildDropdown(value, items, onChanged),
      ],
    );
  }

  Widget _disciplineChip(String label) {
    final isSelected = selectedDisciplines.contains(label);
    return GestureDetector(
      onTap: () => setState(() => isSelected
          ? selectedDisciplines.remove(label)
          : selectedDisciplines.add(label)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
