import 'package:flutter/material.dart';

enum CustomButtonType { elevated, outlined }

class CustomButton extends StatelessWidget {
  final CustomButtonType type;
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color buttonColor;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.type,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.buttonColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: type == CustomButtonType.elevated
          ? ElevatedButton.icon(
              label: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              icon: Icon(
                icon,
                color: iconColor,
              ),
              style: ElevatedButton.styleFrom(
                primary: buttonColor,
              ),
              onPressed: onPressed,
            )
          : OutlinedButton.icon(
              label: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: buttonColor, // Border color for OutlinedButton
                ),
              ),
              icon: Icon(
                icon,
                color: iconColor,
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  width: 2,
                  color: buttonColor, // Border color for OutlinedButton
                ),
              ),
              onPressed: onPressed,
            ),
    );
  }
}
