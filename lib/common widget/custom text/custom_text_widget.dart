import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.maxLines,
    this.textAlign = TextAlign.center,
    this.left = 0,
    this.right = 0,
    this.top = 0,
    this.bottom = 0,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.black,
    this.text = "",
    this.overflow = TextOverflow.ellipsis,
    this.letterSpace,
    this.underlined = false, // Optional parameter for underline
    this.underlineColor = Colors.black, // Optional parameter for underline color
    this.underlineThickness = 2.0, // Optional parameter for underline thickness
  });

  final double left;
  final double right;
  final double top;
  final double bottom;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String text;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final double? letterSpace;
  final bool underlined; // Track the underline option
  final Color underlineColor; // Track the underline color
  final double underlineThickness; // Track the underline thickness

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: Text(
        text, // Actual text
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.openSans(
          letterSpacing: letterSpace,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          decoration: underlined ? TextDecoration.underline : TextDecoration.none, // Conditionally add underline
          decorationColor: underlined ? underlineColor : Colors.transparent, // Set the underline color
          decorationThickness: underlined ? underlineThickness : 0.0, // Set the thickness of the underline
        ),
      ),
    );
  }
}
