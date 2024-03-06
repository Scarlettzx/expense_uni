import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../bloc/fare_bloc.dart';

class SummaryList extends StatefulWidget {
  final FareBloc fareBloc;
  const SummaryList({
    super.key,
    required this.fareBloc,
  });

  @override
  State<SummaryList> createState() => _SummaryListState();
}

class _SummaryListState extends State<SummaryList> {
  @override
  void initState() {
    super.initState();
    // widget.fareBloc.add(CalculateSummaryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FareBloc, FareState>(
      builder: (context, state) {
        // print('show summary');
        // print(state);
        if (state.status == FetchStatus.finish) {
          int total = state.listlocationandfuel.isNotEmpty
              ? state.listlocationandfuel
                  .map((item) => item.total)
                  .reduce((value, element) => value + element)
              : 0;

          int personal = state.listlocationandfuel.isNotEmpty
              ? state.listlocationandfuel
                  .map((item) => item.personal)
                  .reduce((value, element) => value + element)
              : 0;

          int net = state.listlocationandfuel.isNotEmpty
              ? state.listlocationandfuel
                  .map((item) => item.net)
                  .reduce((value, element) => value + element)
              : 0;
          return Column(
            children: [
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ระยะทางรวม',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  Text(
                    '${NumberFormat("###,##0.00#", "en_US").format(total)} กม.',
                    // : '${NumberFormat("###,###.00#", "en_US").format(double.parse(allowanceRateInternational.toString()))} บาท',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  )
                ],
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ใช้ส่วนตัว',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  Text(
                    '${NumberFormat("###,##0.00#", "en_US").format(personal)} กม.',
                    // : '${NumberFormat("###,###.00#", "en_US").format(double.parse(allowanceRateInternational.toString()))} บาท',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  )
                ],
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ระยะทางที่ใช้ในการทำงาน',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  Text(
                    '${NumberFormat("###,##0.00#", "en_US").format(net)} กม.',
                    // : '${NumberFormat("###,###.00#", "en_US").format(double.parse(allowanceRateInternational.toString()))} บาท',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  )
                ],
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'รวมระยะทางทั้งสิ้น',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  Text(
                    '${NumberFormat("###,##0.00#", "en_US").format(net * 5)} บาท',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                ],
              ),
              // Gap(5),
            ],
          );

          //   return Text(
          //     'ระยะทางรวม\n'
          //     '$total  กม.\n'
          //     'ใช้ส่วนตัว\n'
          //     '$personal กม.\n'
          //     'ระยะทางที่ใช้ในการทำงาน\n'
          //     '$net กม.\n'
          //     'รวมระยะทางทั้งสิ้น\n'
          //     '${net * 5} บาท',
          //     style:
          //         const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //   );
        }
        return const SizedBox(); // ถ้าไม่มีข้อมูลให้ส่งคืน SizedBox
      },
    );
  }
}
