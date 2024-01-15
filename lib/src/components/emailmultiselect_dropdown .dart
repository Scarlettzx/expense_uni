import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class EmailMultiSelectDropDown extends StatefulWidget {
  final Function(List<String>) onOptionSelected;
  final List<ValueItem> options;

  const EmailMultiSelectDropDown({
    super.key,
    required this.onOptionSelected,
    required this.options,
  });

  @override
  State<EmailMultiSelectDropDown> createState() =>
      _EmailMultiSelectDropDownState();
}

class _EmailMultiSelectDropDownState extends State<EmailMultiSelectDropDown> {
  List<String> selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return MultiSelectDropDown(
      onOptionSelected: (options) {
        setState(() {
          selectedValues = options
              .map((item) {
                if (item.value != null) {
                  final email = item.label.split('\n')[1];
                  return email.trim();
                }
                return null;
              })
              .whereType<String>() // Filter out null values
              .toList();
          widget.onOptionSelected(selectedValues);
        });
        FocusScope.of(context).unfocus();
        debugPrint(selectedValues.toString());
      },
      showClearIcon: true,
      options: widget.options,
      maxItems: 3,
      searchEnabled: true,
      borderRadius: 30,
      selectionType: SelectionType.multi,
      chipConfig: const ChipConfig(
        wrapType: WrapType.scroll,
        autoScroll: true,
      ),
      dropdownHeight: 300,
      optionTextStyle: const TextStyle(fontSize: 16),
      selectedOptionIcon: const Icon(Icons.check_circle),
    );
  }
}
