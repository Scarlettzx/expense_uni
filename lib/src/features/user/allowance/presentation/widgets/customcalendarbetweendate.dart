// import 'package:custom_date_range_picker/custom_date_range_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// // @immutable
// class CustomCalendarBetweenDate extends StatefulWidget {
//    final DateTime? startDate;
//    final DateTime? endDate;
//    final TextEditingController? startDateController;
//    final TextEditingController? endDateController;
//    final String? betweenDays;
//   CustomCalendarBetweenDate(
//       {super.key,
//       required this.startDate,
//       required this.endDate,
//       required this.startDateController,
//       required this.endDateController});

//   @override
//   State<CustomCalendarBetweenDate> createState() =>
//       _CustomCalendarBetweenDateState();
// }

// class _CustomCalendarBetweenDateState extends State<CustomCalendarBetweenDate> {
//   int daysDifferenceBetween(DateTime from, DateTime to) {
//     from = DateTime(from.year, from.month, from.day);
//     to = DateTime(to.year, to.month, to.day);
//     return (to.difference(from).inHours / 24).round();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         showCustomDateRangePicker(
//           context,
//           dismissible: true,
//           backgroundColor: Colors.black,
//           minimumDate: DateTime.now(),
//           maximumDate: DateTime.now().add(const Duration(days: 365)),
//           endDate: widget.endDate,
//           startDate: widget.startDate,
//           onApplyClick: (start, end) {
//             setState(() {
//               widget.endDate = end;
//               widget.startDate = start;
//               final currentDay = DateTime.now(); // Current date
//               final differenceFormTwoDates = daysDifferenceBetween(start, end);
//               final differenceFormCurrent = daysDifferenceBetween(start, end);
//               var daysGet = differenceFormTwoDates + 1;
//               widget.betweenDays = daysGet.toString();
//               var formatterStartdate = DateFormat('dd-MM-yyyy');
//               String formattedDate = formatterStartdate.format(start);
//               var formatterEnddate = DateFormat('dd-MM-yyyy');
//               String formattedEDate = formatterEnddate.format(end);
//               widget.startDateController!.text = formattedDate.toString();
//               widget.endDateController!.text = formattedEDate.toString();
//             });
//           },
//           onCancelClick: () {
//             setState(() {
//               widget.endDate = null;
//               widget.startDate = null;
//             });
//           },
//           primaryColor: Colors.purple,
//         );
//       },
//     );
//   }
// }
