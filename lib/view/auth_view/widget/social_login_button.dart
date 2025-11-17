import 'package:flutter/material.dart';
import 'package:calebshirthum/uitilies/app_images.dart'; // Assuming AppImages.appleIcon is defined

class SocialLoginButtons extends StatelessWidget {
  final VoidCallback? onGoogleTap;
  final VoidCallback? onAppleTap;

  const SocialLoginButtons({
    Key? key,
    this.onGoogleTap,
    this.onAppleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Google Login Button
        GestureDetector(
          onTap: onGoogleTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Image.asset(
                "assets/images/google.png",
                width: 30,
              ),
            ),
          ),
        ),

        SizedBox(width: 20),

        // Apple Login Button
        GestureDetector(
          onTap: onAppleTap,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Image.asset(
                AppImages.appleIcon,
                width: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
