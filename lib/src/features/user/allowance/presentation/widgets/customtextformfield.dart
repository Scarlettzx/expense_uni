import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
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
      ),
    );
  }
}
