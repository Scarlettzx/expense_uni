import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import 'daterangepicker.dart';

class DateInputField extends StatelessWidget {
  final String labelText;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final DateTime? startDate;
  final DateTime? endDate;
  // final Function(DateTime)? onDateSelected;
  final Function(DateTime, DateTime) onApplyClick;
  final Function() onCancelClick;
  const DateInputField({
    Key? key,
    required this.labelText,
    required this.startDateController,
    required this.endDateController,
    required this.startDate,
    required this.endDate,
    // required this.onDateSelected,
    required this.onApplyClick,
    required this.onCancelClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        Text(
          labelText,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade600,
          ),
        ),
        const Gap(10),
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2.0,
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(35),
          ),
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).devicePixelRatio * 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text((labelText == 'วันที่เริ่มต้น')
                    ? formatThaiDate(
                        startDateController.text.replaceAll('/', '-'))
                    : formatThaiDate(
                        endDateController.text.replaceAll('/', '-'))),
                DateRangePickerIconButton(
                  startDate: startDate,
                  endDate: endDate,
                  startDateController: startDateController,
                  endDateController: endDateController,
                  onApplyClick: onApplyClick,
                  onCancelClick: onCancelClick,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String formatThaiDate(String datetime) {
    // แปลงวันที่จาก String เป็น DateTime
    DateTime date = DateTime.parse(datetime);
    var thaiDateFormat = DateFormat('d MMMM y', 'th_TH');
    return thaiDateFormat
        .format(date)
        .replaceAll('${date.year}', '${date.year + 543}');
  }
}
