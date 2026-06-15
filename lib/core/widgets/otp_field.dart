import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:split_uz/core/theme/app_colors.dart';

class OtpField extends StatelessWidget {
  final TextEditingController controller;
  const OtpField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      controller: controller,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      defaultPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 56,
        height: 56,
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white),
        ),
      ),
    );
  }
}
