import 'package:calebshirthum/common%20widget/custom_button_widget.dart';
import 'package:calebshirthum/uitilies/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';
import '../../../common widget/custom_text_filed.dart';
import '../../../uitilies/custom_loader.dart';
import '../home_view/controller/my_profile_controller.dart';
import 'controller/update_profile_controller.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<ProfileInformationScreen> createState() =>
      _ProfileInformationScreenState();
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  final GetProfileController _getProfileController =
      Get.put(GetProfileController());

  final UpdateProfileController _updateProfileController =
      Get.put(UpdateProfileController());

  String? selectedBelt;
  String? selectedFeet = "5";
  String? selectedInches = "0";
  List<String> selectedDisciplines = [];

  final List<String> beltRanks = [
    "Select One",
    "White",
    "Blue",
    "Purple",
    "Brown",
    "Black"
  ];

  final List<String> feetOptions = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];

  final List<String> inchesOptions = [
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11"
  ];

  final List<String> disciplinesOptions = [
    "Jiu Jitsu",
    "Wrestling",
    "Judo",
    "MMA",
    "Boxing",
    "Muay Thai",
    "Kickboxing"
  ];

  final TextEditingController homeGymController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController favoriteQuoteController = TextEditingController();

  String _normalize(String? s) => s?.trim().toLowerCase() ?? '';

  String? _findBeltMatch(String? apiValue) {
    final normalized = _normalize(apiValue);
    if (normalized.isEmpty) return null;

    for (final rank in beltRanks) {
      if (_normalize(rank) == normalized) {
        return rank;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    ever(_getProfileController.profile, (_) => _populateFromProfile());

    if (_getProfileController.profile.value.data != null) {
      _populateFromProfile();
    }
  }

  void _populateFromProfile() {
    final data = _getProfileController.profile.value.data;
    if (data == null) return;

    setState(() {
      final match = _findBeltMatch(data.beltRank);
      selectedBelt = match ?? beltRanks[0];

      final cm = data.height?.amount ?? 0;
      if (cm > 0) {
        final totalInches = cm / 2.54;
        selectedFeet = (totalInches ~/ 12).toString();
        selectedInches = (totalInches % 12).round().toString();
      }

      // Disciplines
      selectedDisciplines = List.from(data.disciplines);

      // Text fields
      homeGymController.text = data.homeGym ?? "";
      weightController.text = (data.weight ?? "")
          .replaceAll(RegExp(r'kg', caseSensitive: false), '')
          .trim();
      favoriteQuoteController.text = data.favouriteQuote ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backRoudnColors,
      appBar: const CustomAppBar(
        title: "Profile Information",
        showLeadingIcon: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Belt Rank
            CustomText(
              text: "Belt Rank",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            _buildDropdownField(
              selectedBelt ?? beltRanks[0],
              beltRanks,
              (String? value) => setState(() => selectedBelt = value),
            ),
            SizedBox(height: 14.h),

            // Home Gym
            CustomText(
              text: "Add Home Gym",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              controller: homeGymController,
              hintText: "Enter your home gym",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 14.h),

            // Height
            CustomText(
              text: "Add Height",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Feet",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textFieldNameColor,
                      ),
                      SizedBox(height: 6.h),
                      _buildDropdownField(
                        selectedFeet ?? feetOptions[4],
                        feetOptions,
                        (String? value) => setState(() => selectedFeet = value),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Inches",
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textFieldNameColor,
                      ),
                      SizedBox(height: 6.h),
                      _buildDropdownField(
                        selectedInches ?? inchesOptions[0], // default "0"
                        inchesOptions,
                        (String? value) =>
                            setState(() => selectedInches = value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),

            // Weight
            CustomText(
              text: "Add Weight",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              controller: weightController,
              hintText: "Enter your weight",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 14.h),

            // Disciplines
            CustomText(
              text: "Disciplines",
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: disciplinesOptions
                  .map(
                    (text) => _buildChip(
                      text,
                      selectedDisciplines.contains(text),
                      () => setState(() {
                        if (selectedDisciplines.contains(text)) {
                          selectedDisciplines.remove(text);
                        } else {
                          selectedDisciplines.add(text);
                        }
                      }),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 14.h),

            // Favorite Quote
            CustomText(
              text: "Favorite Quote",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(height: 6.h),
            CustomTextField(
              controller: favoriteQuoteController,
              hintText: "Enter your favorite inspirational quote",
              showObscure: false,
              fillColor: AppColors.backRoudnColors,
              hintTextColor: AppColors.hintTextColors,
            ),
            SizedBox(height: 24.h),

            Obx(() {
              return _updateProfileController.isLoading.value == true
                  ? Center(child: CustomLoader())
                  : CustomButtonWidget(
                      btnText: 'Save',
                      onTap: () {
                        final heightCm = (int.parse(selectedFeet!) * 12 +
                                int.parse(selectedInches!)) *
                            2.54;
                        _updateProfileController.updateProfile(
                          beltRank: selectedBelt!,
                          disciplines: selectedDisciplines,
                          favouriteQuote: favoriteQuoteController.text,
                          weight: weightController.text,
                          heightCm: heightCm,
                          homeGym: homeGymController.text,
                        );
                      },
                      iconWant: false,
                      btnColor: AppColors.mainColor,
                    );
            })
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      String value, List<String> items, Function(String?) onChanged) {
    if (!items.contains(value)) {
      value = items[0];
    }

    return Container(
      height: 46.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: AppColors.backRoudnColors,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFB9B9B9)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // Chip Builder
  Widget _buildChip(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : const Color(0xFFE9E9E9),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: CustomText(
          text: text,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : const Color(0xFF686868),
        ),
      ),
    );
  }

  @override
  void dispose() {
    homeGymController.dispose();
    weightController.dispose();
    favoriteQuoteController.dispose();
    super.dispose();
  }
}
