import 'package:flutter/material.dart';

class RequiredText extends StatelessWidget {
  final String labelText;
  final String asteriskText;
  final TextStyle textStyle;
  final TextStyle asteriskStyle;

  RequiredText({
    required this.labelText,
    required this.asteriskText,
    this.textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      fontFamily: 'kanit',
      color: Color.fromRGBO(117, 117, 117, 1),
    ),
    this.asteriskStyle = const TextStyle(
      color: Colors.red,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: labelText,
            style: textStyle,
          ),
          TextSpan(
            text: asteriskText,
            style: asteriskStyle,
          ),
        ],
      ),
    );
  }
}
