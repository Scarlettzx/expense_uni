import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class CustomSelectedTabbar extends StatefulWidget {
  final List<String> labels;
  final int selectedIndex;
  final Function(int)? onTabChanged;
  CustomSelectedTabbar({
    super.key,
    required this.labels,
    required this.selectedIndex,
    this.onTabChanged,
  });

  @override
  State<CustomSelectedTabbar> createState() => _CustomSelectedTabbarState();
}

class _CustomSelectedTabbarState extends State<CustomSelectedTabbar> {
  @override
  Widget build(BuildContext context) {
    return FlutterToggleTab(
      width: MediaQuery.of(context).devicePixelRatio * 20,
      borderRadius: 30,
      height: MediaQuery.of(context).devicePixelRatio * 15,
      selectedIndex: widget.selectedIndex,
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
      labels: widget.labels,
      selectedLabelIndex: (index) {
        if (widget.onTabChanged != null) {
          widget.onTabChanged!(index);
        }
      },
      isScroll: false,
    );
  }
}
