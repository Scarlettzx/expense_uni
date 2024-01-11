import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class CustomMotionToast {
  static void show({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color primaryColor,
    required double width,
    required double height,
    required AnimationType
        animationType, // Import the correct MotionToastAnimationType
    double fontSizeTitle = 16.0,
    double fontSizeDescription = 14.0,
  }) {
    MotionToast(
      animationType: animationType,
      icon: icon,
      primaryColor: primaryColor,
      title: Text(
        title,
        style: TextStyle(fontSize: fontSizeTitle),
      ),
      description: Text(
        description,
        style: TextStyle(fontSize: fontSizeDescription),
      ),
      width: width,
      height: height,
    ).show(context);
  }
}
