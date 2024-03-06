import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/entities.dart';

class SurplusDetail extends StatelessWidget {
  final SurplusEntity surplus;

  const SurplusDetail({Key? key, required this.surplus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ส่วนเกินขั้น ${surplus.idSurplus}",
                  style: TextStyle(color: Colors.grey[500]),
                ),
                Text(
                  "${NumberFormat("#,##0.00", "en_US").format(surplus.numberSurplus?.toDouble() ?? 0)} บาท",
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "บริษัทช่วยเหลือเพิ่ม(%)",
                  style: TextStyle(color: Colors.grey[500]),
                ),
                Text(
                  surplus.surplusPercent!.toStringAsFixed(1),
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
