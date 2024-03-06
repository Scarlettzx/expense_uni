import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(dynamic) onSuggestionTap;
  final List<SearchFieldListItem> suggestions;
  final String? Function(String?)? validator;

  const CustomSearchField({super.key, 
    required this.controller,
    required this.onSuggestionTap,
    required this.suggestions,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SearchField(
      controller: controller,
      onSuggestionTap: onSuggestionTap,
      suggestions: suggestions,
      validator: (String? value) {
        if (validator != null) {
          String? validationError = validator!(value);
          if (validationError != null) {
            return validationError;
          }
        }
        if (value == null || value.isEmpty) {
          return 'Please enter a valid value';
        }
        return null;
      },
      itemHeight: 50,
      emptyWidget: Container(
        alignment: Alignment.center,
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 8.0,
              spreadRadius: 20.0,
              offset: Offset(2.0, 5.0),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8.0),
        child: Text('No suggestions found'),
      ),
      suggestionsDecoration: SuggestionDecoration(
        border: Border.all(width: 2, color: Colors.grey.shade300),
        padding: EdgeInsets.only(right: 8, top: 8, bottom: 8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 8.0,
            spreadRadius: 20.0,
            offset: Offset(2.0, 5.0),
          ),
        ],
      ),
      searchInputDecoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              width: 2.0, color: Color.fromARGB(255, 252, 119, 119)),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(width: 2.0, color: Colors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        errorStyle: TextStyle(fontSize: 15),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: 2.0, color: Colors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(width: 2.0, color: Colors.grey.withOpacity(0.3)),
        ),
      ),
    );
  }
}