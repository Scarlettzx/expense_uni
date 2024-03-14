import 'package:flutter/material.dart';

class SummaryDetail extends StatelessWidget {
  final String label;
  final String value;
  final String? additionalText;

  const SummaryDetail({
    Key? key,
    required this.label,
    required this.value,
    this.additionalText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        additionalText != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  Text(additionalText!,
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              )
            : Text(label,
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
        Text(value, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}
