import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import '../../../uitilies/app_colors.dart';

class OtpForm extends StatefulWidget {
  final TextEditingController controller;

  const OtpForm({super.key, required this.controller});

  @override
  _OtpFormState createState() => _OtpFormState();

  @override
  String toStringShort() => 'Rounded Filled';
}

class _OtpFormState extends State<OtpForm> {
  final focusNode = FocusNode();
  bool showError = false;

  @override
  void dispose() {
    widget.controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const length = 4;
    const errorColor = Color.fromRGBO(255, 234, 238, 1);
    const fillColor = Color.fromARGB(255, 240, 240, 240);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.poppins(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.transparent),
      ),
    );

    return SizedBox(
      height: 60,
      child: Pinput(
        length: length,
        controller: widget.controller,
        focusNode: focusNode,
        defaultPinTheme: defaultPinTheme.copyWith(
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: Colors.white),
          ),
        ),
        onCompleted: (pin) {
          setState(() => showError = pin != '5111');
        },
        focusedPinTheme: defaultPinTheme.copyWith(
          height: 60,
          width: 60,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: Color(0xFFECEEF1)),
            shape: BoxShape.circle,
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: errorColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
