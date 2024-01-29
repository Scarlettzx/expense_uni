// custom_input_decoration.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomInputDecoration {
  static InputDecoration getInputDecoration({
    Widget? suffixIcon,
    String? labelText,
  }) {
    return InputDecoration(
      // fillColor: const Color.fromARGB(255, 237, 237, 237).withOpacity(0.5),
      // filled: true,
      isDense: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          width: 2.0,
          color: Colors.grey.withOpacity(0.3),
        ),
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 16,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: Colors.grey.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      errorStyle: TextStyle(fontSize: 15),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: Colors.grey.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            width: 2.0, color: Color.fromARGB(255, 252, 119, 119)),
        borderRadius: BorderRadius.circular(30),
      ),
      suffixIcon: suffixIcon,
      labelText: labelText,
    );
  }
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Save the cursor position
    final int cursorPosition = newValue.selection.baseOffset;

    // Allow only digits and one decimal point
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Allow only one decimal point
    if (newText.contains('.') &&
        newText.substring(newText.indexOf('.') + 1).contains('.')) {
      newText = oldValue.text;
    }
    double? value = double.tryParse(newText);
    if (value != null) {
      newText = NumberFormat("###,###.00#", "en_US").format(value);

      // Always place the cursor at the end
      final int newCursorPosition = newText.length;
      return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: newCursorPosition));
    } else {
      // Restore the cursor position
      return newValue.copyWith(
          text: newText,
          selection: TextSelection.collapsed(offset: cursorPosition));
    }
  }
}
