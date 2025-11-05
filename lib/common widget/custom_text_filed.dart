import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../uitilies/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool showObscure;
  final bool? readOnly;
  final IconData? prefixIcon;
  final String? imagePrefix;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Color? fillColor;
  final Color? borderColor;
  final int? maxLines;
  final Color? hintTextColor; // Hint text color
  final IconData? suffixIcon; // Suffix icon
  final String? suffixIconAsset; // Suffix icon asset (image)
  final VoidCallback? onSuffixTap; // Optional tap for suffix
  final String? Function(String?)?
      validator; // Added optional validator parameter

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.showObscure,
    this.keyboardType,
    this.controller,
    this.prefixIcon,
    this.imagePrefix,
    this.fillColor,
    this.borderColor,
    this.maxLines,
    this.readOnly,
    this.hintTextColor,
    this.suffixIcon,
    this.suffixIconAsset,
    this.onSuffixTap,
    this.validator, // Added
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        readOnly: widget.readOnly ?? false,
        obscureText: widget.showObscure ? _obscureText : false,
        maxLines: widget.maxLines ?? 1,
        style: GoogleFonts.poppins(
          fontSize: 12.h,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(
              color: widget.borderColor ?? Color(0xFFB9B9B9),
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(
              color: widget.borderColor ?? Color(0xFFB9B9B9),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.sp),
            borderSide: BorderSide(
              color: widget.borderColor ?? Color(0xFFB9B9B9),
              width: 1,
            ),
          ),
          prefixIcon: widget.imagePrefix != null
              ? Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    widget.imagePrefix!,
                    width: 24.w,
                    height: 24.h,
                    fit: BoxFit.contain,
                  ),
                )
              : (widget.prefixIcon != null
                  ? Icon(widget.prefixIcon, color: Colors.white)
                  : null),
          // Suffix icon logic: showObscure takes priority
          suffixIcon: widget.showObscure
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Color(0xFF666666),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : (widget.suffixIcon != null
                  ? IconButton(
                      icon: Icon(widget.suffixIcon, color: Color(0xFF666666)),
                      onPressed: widget.onSuffixTap,
                    )
                  : (widget.suffixIconAsset != null
                      ? GestureDetector(
                          onTap: widget.onSuffixTap,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                              widget.suffixIconAsset!,
                              width: 24.w,
                              height: 24.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      : null)),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 12.h,
            color: widget.hintTextColor ?? Color(0xff989898),
          ),
        ),
        validator: widget.validator, // Added validator to TextFormField
      ),
    );
  }
}
