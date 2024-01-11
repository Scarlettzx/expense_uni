import 'package:flutter/widgets.dart';

class TextHeadRec extends StatelessWidget {
  final String title;
  const TextHeadRec({Key? key, required this.title}) : super(key: key);

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
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ]),
    );
  }
}

class TextSubHeadRec extends StatelessWidget {
  final String title;
  const TextSubHeadRec({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).devicePixelRatio * 9,
          right: MediaQuery.of(context).devicePixelRatio * 8,
          bottom: MediaQuery.of(context).devicePixelRatio * 4),
      child: Row(children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        )
      ]),
    );
  }
}
