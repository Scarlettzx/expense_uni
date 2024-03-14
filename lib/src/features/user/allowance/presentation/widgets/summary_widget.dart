import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/bloc/allowance_bloc.dart';

import 'summary_detail.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllowanceBloc, AllowanceState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'สรุปรายการ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Gap(10),
            SummaryDetail(
              label: 'สรุปจำนวนวันเดินทาง',
              value:
                  '${NumberFormat("###,##0.00#", "en_US").format(state.sumDays)} วัน',
            ),
             const Gap(5),
            SummaryDetail(
              label: 'เบี้ยเลี้ยง/วัน',
              value:
                  '${NumberFormat("###,##0.00#", "en_US").format(state.allowanceRate)} บาท',
            ),
             const Gap(5),
            SummaryDetail(
              label: 'เบี้ยเลี้ยงตามอัตราราชการ',
              value:
                  '${NumberFormat("###,##0.00#", "en_US").format(state.allowanceRateGoverment)} บาท',
            ),
             const Gap(5),
            SummaryDetail(
              label: 'เบี้ยเลี้ยงส่วนเกินอัตราราชการ',
              value: '${NumberFormat("###,##0.00#", "en_US").format(state.sumSurplus)} บาท',
              additionalText: '(จะถูกนำคิดภาษีเงินได้)',
            ),
             const Gap(5),
            SummaryDetail(
              label: 'มูลค่าสุทธิรวม',
              value: '${NumberFormat("###,##0.00#", "en_US").format(state.sumNet)} บาท',
            ),
            const Gap(20),
            Divider(color: Colors.grey.shade300, height: 1),
            const Gap(25),
          ],
        );
      },
    );
  }
}
