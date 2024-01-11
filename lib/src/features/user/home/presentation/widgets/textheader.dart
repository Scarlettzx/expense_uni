import 'package:flutter/widgets.dart';

class TextHeader extends StatelessWidget {
  final String title;
  const TextHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).devicePixelRatio * 4,
          left: MediaQuery.of(context).devicePixelRatio * 8,
          right: MediaQuery.of(context).devicePixelRatio * 8,
          bottom: MediaQuery.of(context).devicePixelRatio * 3),
      child: Row(children: [
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}
