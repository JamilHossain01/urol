import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class UploadCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Function(File? file)? onFileSelected;

  const UploadCard({
    Key? key,
    required this.title,
    this.description =
    "Click to upload or drag and drop\nPDF, JPG, PNG up to 10MB",
    this.icon = Icons.upload_rounded,
    this.onFileSelected,
  }) : super(key: key);

  @override
  State<UploadCard> createState() => _UploadCardState();
}

class _UploadCardState extends State<UploadCard> {
  File? _selectedFile;

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickFile() async {
    // Show options to choose image or PDF
    final choice = await showModalBottomSheet<String>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Pick Image from Gallery"),
              onTap: () => Navigator.pop(context, 'gallery'),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Take Photo"),
              onTap: () => Navigator.pop(context, 'camera'),
            ),
            ListTile(
              leading: Icon(Icons.picture_as_pdf),
              title: Text("Pick PDF"),
              onTap: () => Navigator.pop(context, 'pdf'),
            ),
          ],
        ),
      ),
    );

    if (choice == null) return;

    File? file;

    if (choice == 'gallery') {
      final pickedImage =
      await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) file = File(pickedImage.path);
    } else if (choice == 'camera') {
      final pickedImage =
      await _imagePicker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) file = File(pickedImage.path);
    } else if (choice == 'pdf') {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null && result.files.single.path != null) {
        file = File(result.files.single.path!);
      }
    }

    if (file != null) {
      setState(() {
        _selectedFile = file;
      });
      if (widget.onFileSelected != null) {
        widget.onFileSelected!(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: _pickFile,
          child: DottedBorder(
            color: Colors.grey,
            strokeWidth: 1,
            borderType: BorderType.RRect,
            radius: Radius.circular(12.r),
            dashPattern: [6, 3],
            child: Container(
              width: double.infinity,
              height: 120.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: _selectedFile == null
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.icon, size: 32.sp, color: Colors.grey),
                  SizedBox(height: 8.h),
                  Text(
                    widget.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              )
                  : Padding(
                padding: EdgeInsets.all(12.w),
                child: Row(
                  children: [
                    if (_selectedFile!.path.endsWith('.pdf'))
                      Icon(Icons.picture_as_pdf,
                          size: 36.sp, color: Colors.redAccent)
                    else
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.file(
                          _selectedFile!,
                          width: 60.w,
                          height: 60.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        _selectedFile!.path.split('/').last,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.redAccent),
                      onPressed: () {
                        setState(() {
                          _selectedFile = null;
                        });
                        if (widget.onFileSelected != null) {
                          widget.onFileSelected!(null);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
