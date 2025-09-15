// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../common controller/image picker controller/image_picker_controller.dart';
import '../uitilies/app_colors.dart';


class ImagePickerDialog extends StatelessWidget {
  final ImagePickerController controller = Get.put(ImagePickerController());
  final Function(ImageSource) onImagePicked;

  ImagePickerDialog({required this.onImagePicked});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Image Source',
              style: GoogleFonts.kumbhSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _handleImageSource(ImageSource.camera);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.camera,
                        color: AppColors.secondColor,
                        size: 40,
                      ),
                      Text('Camera'),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _handleImageSource(ImageSource.gallery);
                  },
                  child: Column(
                    children: [
                      Icon(
                        Icons.photo,
                        color: AppColors.secondColor,
                        size: 40,
                      ),
                      Text('Gallery'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _handleImageSource(ImageSource source) {
    onImagePicked(source);
    Get.back();
  }
}
