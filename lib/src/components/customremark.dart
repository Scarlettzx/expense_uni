import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomRemark extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final int minLines;
  final int maxLines;
  final int maxLength;
  final String counterText;

  const CustomRemark({
    super.key,
    required this.controller,
    this.onChanged,
    this.minLines = 2,
    this.maxLines = 5,
    this.maxLength = 500,
    this.counterText = '',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
        decoration: InputDecoration(
          counterText: counterText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 2.0, color: Color.fromARGB(255, 252, 119, 119)),
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide:
                BorderSide(width: 2.0, color: Colors.grey.withOpacity(0.3)),
          ),
        ),
      ),
    );
  }
}
