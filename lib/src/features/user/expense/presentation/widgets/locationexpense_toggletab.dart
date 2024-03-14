import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:gap/gap.dart';

class LocationExpenseToggleTab extends StatefulWidget {
  final List<String> locationOptions; // List of toggle tab labels
  final int? initialSelectedIndex; // Initial selected index (optional)
  final Function(int) onLabelSelected; // Callback for label selection

  const LocationExpenseToggleTab({
    Key? key,
    required this.locationOptions,
    this.initialSelectedIndex,
    required this.onLabelSelected,
  }) : super(key: key);

  @override
  State<LocationExpenseToggleTab> createState() =>
      _LocationExpenseToggleState();
}

class _LocationExpenseToggleState extends State<LocationExpenseToggleTab> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedTabIndex = ((widget.initialSelectedIndex != null)
        ? widget.initialSelectedIndex
        : 0)!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'สถานที่เกิดค่าใช้จ่าย',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey.shade600,
          ),
        ),
        const Gap(10), // Fixed height for spacing
        FlutterToggleTab(
          width:
              MediaQuery.of(context).devicePixelRatio * 20, // width in percent
          borderRadius: 30,
          height: MediaQuery.of(context).devicePixelRatio * 15,
          selectedIndex: _selectedTabIndex,
          selectedBackgroundColors: [Color(0xffff99ca)],
          selectedTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          unSelectedTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          labels: widget.locationOptions,
          selectedLabelIndex: (index) {
            setState(() {
              _selectedTabIndex = index;
              widget.onLabelSelected(index); // Call callback
            });
          },
          isScroll: false,
        ),
        const Gap(20), // Fixed height for spacing
      ],
    );
  }
}
