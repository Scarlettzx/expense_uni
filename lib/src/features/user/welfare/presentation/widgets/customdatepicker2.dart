import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../components/custominputdecoration.dart';

class CustomDatePicker2 extends StatefulWidget {
  final TextEditingController controller;

  const CustomDatePicker2({super.key, required this.controller});

  @override
  State<CustomDatePicker2> createState() => _CustomDatePicker2State();
}

class _CustomDatePicker2State extends State<CustomDatePicker2> {
  final selectDateController = TextEditingController();
  DateTime? selectedDate;
  var thaiDateFormat = DateFormat('d MMMM y', 'th_TH');
  @override
  void initState() {
    super.initState();
    setDefaultDate();
  }

  // void setDefaultDate() {
  //   var now = DateTime.now();
  //   String formattedDate = thaiDateFormat
  //       .format(now)
  //       .replaceAll('${now.year}', '${now.year + 543}');
  //   selectDateController.text = formattedDate;
  //   var formatter = DateFormat('yyyy/MM/dd');
  //   widget.controller.text = formatter.format(now);
  // }

  void setDefaultDate() {
    DateTime inputDate = DateFormat("yyyy/MM/dd").parse(widget.controller.text);
    String formattedDate = thaiDateFormat
        .format(inputDate)
        .replaceAll('${inputDate.year}', '${inputDate.year + 543}');
    selectDateController.text = formattedDate;
    selectedDate = inputDate;
    // var formatter = DateFormat('yyyy/MM/dd');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () async {
          selectedDate = await showRoundedDatePicker(
            fontFamily: 'kanit',
            initialDatePickerMode: DatePickerMode.day,
            theme: ThemeData(
              primaryColor: const Color.fromARGB(255, 252, 119, 119),
              hintColor: Colors.green[800],
            ),
            styleDatePicker: MaterialRoundedDatePickerStyle(
              textStyleButtonNegative: const TextStyle(
                color: Color.fromARGB(255, 252, 119, 119),
              ),
              textStyleButtonPositive: const TextStyle(
                color: Color.fromARGB(255, 252, 119, 119),
              ),
              textStyleDayOnCalendarSelected:
                  const TextStyle(color: Colors.white),
              decorationDateSelected: const BoxDecoration(
                color: Color.fromARGB(255, 252, 119, 119),
                shape: BoxShape.circle,
              ),
              textStyleDayButton: const TextStyle(
                fontFamily: 'kanit',
                fontSize: 20,
                color: Colors.white,
              ),
              textStyleYearButton: const TextStyle(
                fontFamily: 'kanit',
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            height: 300,
            initialDate: (selectedDate != null) ? selectedDate : null,
            context: context,
            locale: const Locale("th", "TH"),
            era: EraMode.BUDDHIST_YEAR,
          );
          checkselectdate();
        },
        child: AbsorbPointer(
          absorbing: true,
          child: TextFormField(
            style: const TextStyle(color: Colors.black),
            controller: selectDateController,
            readOnly: true, // Set to true to make it non-editable
            enabled: false, // Set to false to disable the input field
            decoration: CustomInputDecoration.getInputDecoration(
              suffixIcon: Icon(
                Icons.calendar_today,
                color: Colors.grey.withOpacity(0.6),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a value';
              }
              return null; // Return null if the input is valid
            },
          ),
        ),
      ),
    );
  }

  Future<void> checkselectdate() async {
    if (selectedDate != null) {
      setState(() {
        // DateFormat
        // selectedDay = selectedDate;

        // var thaiLocale = const Locale('th', 'TH');
        var formatter = DateFormat('yyyy/MM/dd');
        widget.controller.text = formatter.format(selectedDate!);

        print('data ${widget.controller.text}');
        var formattedDate = thaiDateFormat
            .format(selectedDate!)
            .replaceAll('${selectedDate!.year}', '${selectedDate!.year + 543}');
        selectDateController.text = formattedDate;
        print(selectedDate);
        print((selectDateController.text));
      });
    }
  }
}
