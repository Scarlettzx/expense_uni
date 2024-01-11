import 'package:flutter/widgets.dart';

class TextSubHeader extends StatelessWidget {
  final String title;
  const TextSubHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).devicePixelRatio * 8,
          right: MediaQuery.of(context).devicePixelRatio * 8,
          bottom: MediaQuery.of(context).devicePixelRatio * 4),
      child: Row(children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        )
      ]),
    );
  }
}
