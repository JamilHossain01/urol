import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/dot_border_container.dart';
import '../../../../uitilies/app_colors.dart';

class ImageUploadWidget extends StatefulWidget {
  const ImageUploadWidget({Key? key}) : super(key: key);

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _images.add(File(image.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
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

        // 🖼️ Image list + upload box
        SizedBox(
          height: 90.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _images.length + 1,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              if (index == 0) {
                // ➕ Upload button
                return GestureDetector(
                  onTap: _pickImage,
                  child: DottedBorderBox(),
                );
              } else {
                final imageFile = _images[index - 1];
                return Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.file(
                        imageFile,
                        height: 90.h,
                        width: 120.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 4,
                      child: GestureDetector(
                        onTap: () => _removeImage(index - 1),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(2.w),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}


