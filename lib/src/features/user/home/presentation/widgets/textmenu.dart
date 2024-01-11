import 'package:flutter/widgets.dart';

class TextMenu extends StatelessWidget {
  final String title;
  const TextMenu({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).devicePixelRatio * 3,
          left: MediaQuery.of(context).devicePixelRatio * 9,
          right: MediaQuery.of(context).devicePixelRatio * 9,
          bottom: MediaQuery.of(context).devicePixelRatio * 3),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          // textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
