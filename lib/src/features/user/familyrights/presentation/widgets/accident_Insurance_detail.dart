import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/entities.dart';

class AccidentInsuranceDetail extends StatelessWidget {
  final AllRightEntity allright;

  const AccidentInsuranceDetail({Key? key, required this.allright})
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
                Gap(8),
                Text.rich(
                  TextSpan(
                    text: "สิทธิประกันอุบัติเหตุรถชน",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            Gap(10),
            if (allright.opdPrinciple == "OPD_number") ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "OPD  ${allright.opdNumber} ครั้ง",
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                  Text(
                    "ครั้งละ ${NumberFormat("#,##0.00", "en_US").format(allright.opdMoneyPerTimes?.toDouble() ?? 0)} บาท",
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ],
              ),
            ],
            Gap(10),
            Divider(
              color: Colors.grey.shade300,
              height: 3,
              thickness: 2,
            ),
            Gap(10),
            if (allright.ipdPrinciple == "IPD_detail") ...[
              Text(
                "IPD",
                style: TextStyle(color: Colors.grey[800]),
              ),
              Gap(10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: allright.ipd!.map((ipd) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "•  ${ipd.nameList}",
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                        Text(
                          "${NumberFormat("#,##0.00", "en_US").format(ipd.limitList?.toDouble() ?? 0)} บาท",
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
            Gap(10),
            Divider(
              color: Colors.grey.shade300,
              height: 3,
              thickness: 2,
            ),
            Gap(10),
            if (allright.dentalPrinciple == "Dental_detail") ...[
              Text(
                "Dental",
                style: TextStyle(color: Colors.grey[800]),
              ),
              Gap(10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: allright.dental!.map((dental) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "•  ${dental.nameList}",
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                        Text(
                          "${NumberFormat("#,##0.00", "en_US").format(dental.limitList?.toDouble() ?? 0)} บาท",
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
            Gap(10),
          ],
        ),
      ),
    );
  }
}
