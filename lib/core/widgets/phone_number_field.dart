import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:split_uz/core/theme/app_colors.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  const PhoneNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text("+998", style: Theme.of(context).textTheme.bodyLarge),
          ),
          VerticalDivider(
            color: Colors.white.withValues(alpha: 0.08),
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Phone Number",
                hintStyle: TextStyle(color: Colors.grey),
              ),
              inputFormatters: [maskFormatter],
            ),
          ),
        ],
      ),
    );
  }
}

final maskFormatter = MaskTextInputFormatter(
  mask: '## ### ## ##',
  filter: {"#": RegExp(r'[0-9]')},
);
