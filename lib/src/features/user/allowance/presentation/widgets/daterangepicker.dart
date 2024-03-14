import 'package:flutter/material.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:custom_date_range_picker/custom_date_range_picker.dart';

class DateRangePickerIconButton extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final Function(DateTime, DateTime) onApplyClick;
  final Function() onCancelClick;

  const DateRangePickerIconButton({
    Key? key,
    this.startDate,
    this.endDate,
    required this.startDateController,
    required this.endDateController,
    required this.onApplyClick,
    required this.onCancelClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        IconaMoon.calendar2,
        size: 20,
        color: Colors.grey.withOpacity(0.6),
      ),
      onPressed: () {
        showCustomDateRangePicker(
          primaryColor: Colors.purple,
          onApplyClick: (start, end) {
            onApplyClick(start, end);
          },
          onCancelClick: onCancelClick,
          context,
          dismissible: true,
          backgroundColor: Colors.white,
          minimumDate: DateTime.now(),
          maximumDate: DateTime.now().add(const Duration(days: 365)),
          endDate: endDate,
          startDate: startDate,
          fontFamily: 'kanit',
        );
      },
    );
  }
}
