import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../../components/custominputdecoration.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextStyle? style;
  final bool readOnly;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
    this.onChanged,
    this.style,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade600,
          ),
        ),
        const Gap(10),
        TextFormField(
            readOnly: readOnly,
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            style: style,
            decoration: CustomInputDecoration.getInputDecoration()),
        const Gap(20),
      ],
    );
  }
}
