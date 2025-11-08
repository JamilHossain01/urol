import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/dot_border_container.dart';
import '../../../../uitilies/app_colors.dart';

class ImageUploadWidget extends StatelessWidget {
  final XFile? selectedImage;
  final Function(XFile) onImagePicked;

  const ImageUploadWidget({
    Key? key,
    required this.selectedImage,
    required this.onImagePicked,
  }) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      onImagePicked(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Upload Image",
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.mainTextColors,
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: () => _pickImage(context),
          child: Container(
            height: 90.h,
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: Colors.grey),
            ),
            child: selectedImage != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.file(
                File(selectedImage!.path),
                fit: BoxFit.cover,
              ),
            )
                : DottedBorderBox(),
          ),
        ),
      ],
    );
  }
}
