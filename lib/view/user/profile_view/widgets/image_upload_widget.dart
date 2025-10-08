import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../uitilies/app_colors.dart';

class ImageUploadWidget extends StatefulWidget {
  const ImageUploadWidget({super.key});

  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              text: "Upload Image",
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textFieldNameColor,
            ),
            SizedBox(width: 8.w),
            IconButton(
              icon: Icon(Icons.add, size: 24.sp),
              onPressed: _pickImage,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Stack(
          children: [
            Container(
              height: 100.h,
              width: double.infinity,
              color: _selectedImage == null ? Colors.grey[300] : null,
              child: _selectedImage == null
                  ? Center(child: Text("Image Placeholder"))
                  : Image.file(
                _selectedImage!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 100.h,
              ),
            ),
            if (_selectedImage != null)
              Positioned(
                top: 4.h,
                right: 4.w,
                child: IconButton(
                  icon: Icon(Icons.close, size: 20.sp, color: Colors.red),
                  onPressed: _removeImage,
                  padding: EdgeInsets.all(4.w),
                ),
              ),
          ],
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}