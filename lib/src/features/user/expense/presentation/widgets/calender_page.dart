import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatefulWidget {
  final DateTime? selectedDay;
  const CalenderPage({super.key, required this.selectedDay});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('th');
    // Initialize _selectedDay in initState
    _selectedDay =
        (widget.selectedDay != null) ? widget.selectedDay : DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.pink,
        // appBar:
        appBar: AppBar(
          backgroundColor: const Color(0xffE793B8),
          // toolbarOpacity: 5,
          centerTitle: true,
          title: Text('Calendar', style: TextStyle(color: Colors.white)),
        ),
        body: Container(
          child: TableCalendar(
              // currentDay: _focusedDay,
              calendarStyle: CalendarStyle(
                // cellMargin: EdgeInsets.only(left:20),
                canMarkersOverflow: true,
                isTodayHighlighted: true,
                todayTextStyle: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                selectedTextStyle: const TextStyle(
                    color: const Color(0xFFFAFAFA), fontSize: 16.0),
              ),
              // headerVisible: true,
              headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                      fontSize: 25,
                      color: const Color(0xffE793B8),
                      fontWeight: FontWeight.w500)),
              availableGestures: AvailableGestures.all,
              focusedDay: _focusedDay,
              locale: 'th',
              daysOfWeekHeight: 45,
              rowHeight: 50,
              firstDay: DateTime.utc(2010, 01, 01),
              lastDay: DateTime.utc(2055, 12, 31),
              onPageChanged: (focusedDay) {
                print(focusedDay);
                _focusedDay = focusedDay;
              },
              // pageAnimationDuration: Duration(seconds: 1),
              // pageJumpingEnabled: true,
              pageAnimationEnabled: true,
              onDaySelected: (selectedDay, focusedDay) {
                // print(selectedDay);
                // print(focusedDay);
                setState(() {
                  _focusedDay = focusedDay;
                  _selectedDay = selectedDay;
                });
              },
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day)),
        ),
        // backgroundColor: Colors.transparent,
        bottomSheet: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Change this color as needed
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // Adjusted alignment
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Cancel button press
                    Navigator.pop(context, null); // Return null as a result
                  },
                  child: Text('Cancel'),
                ),
                Gap(20),
                ElevatedButton(
                  onPressed: () {
                    // Handle Success button press
                    Navigator.pop(context, _selectedDay);
                  },
                  child: Text('Success'),
                ),
              ],
            ),
          ),
        ));
  }

  // void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
  //   if (!isSameDay(_selectedDay, selectedDay)) {
  //     setState(() {
  //       _focusedDay = focusedDay;
  //       _selectedDay = selectedDay;
  //       _selectedEvents = _getEventsForDay(selectedDay);
  //     });
  //   }
  // }
}
