import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/entities.dart';
import 'surplus_detail.dart';

class HealthInsuranceDetail extends StatelessWidget {
  final AllRightEntity allright;

  const HealthInsuranceDetail({Key? key, required this.allright})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 24,
                  width: 5,
                  color: Colors.blue,
                ),
                const Gap(8),
                Text.rich(
                  const TextSpan(
                    text: "สิทธิประกันสุขภาพ",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "วงเงินรวม",
                  style: TextStyle(color: Colors.grey[800]),
                ),
                Text(
                  "${NumberFormat("#,##0.00", "en_US").format(allright.limit?.toDouble() ?? 0)} บาท",
                  style: TextStyle(color: Colors.grey[800]),
                ),
              ],
            ),
            const Gap(10),
            Divider(
              color: Colors.grey.shade300,
              height: 3,
              thickness: 2,
            ),
            const Gap(10),
            Text.rich(
              const TextSpan(
                text: "ช่วยเหลือส่วนเกิน",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Gap(10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: allright.surplus!.map((surplus) {
                  return SurplusDetail(surplus: surplus);
                }).toList(),
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
