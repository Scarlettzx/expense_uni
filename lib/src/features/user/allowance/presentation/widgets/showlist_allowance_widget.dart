import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/bloc/allowance_bloc.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/widgets/listview_allowance.dart';

import '../pages/allowance_add_list.dart';
import 'required_text.dart';

class ShowListAllowanceWidget extends StatefulWidget {
  final AllowanceBloc allowanceBloc;
  final bool isdraft;
  const ShowListAllowanceWidget({
    super.key,
    required this.allowanceBloc,
    required this.isdraft,
  });

  @override
  State<ShowListAllowanceWidget> createState() =>
      _ShowListAllowanceWidgetState();
}

class _ShowListAllowanceWidgetState extends State<ShowListAllowanceWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RequiredText(
              labelText: 'รายการ',
              asteriskText: '*',
              textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'kanit',
                  color: Colors.black),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30.0),
              onTap: () async {
                Navigator.push(
                  context,
                  PageTransition(
                    duration: Durations.medium1,
                    type: PageTransitionType.rightToLeft,
                    child: AllowanceAddList(
                      allowanceBloc: widget.allowanceBloc,
                      isdraft: widget.isdraft,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffff99ca),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).devicePixelRatio * 7,
                    vertical: MediaQuery.of(context).devicePixelRatio * 2.5),
                child: Text(
                  '+ เพิ่มรายการ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const Gap(10),
        BlocBuilder<AllowanceBloc, AllowanceState>(
          builder: (context, state) {
            final listallowance = state.listExpense;
            if (state.listExpense.isNotEmpty) {
              return ListViewAllowance(
                allowanceBloc: widget.allowanceBloc,
                lisallowance: listallowance,
              );
            }
            return Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).devicePixelRatio * 1,
                  bottom: MediaQuery.of(context).devicePixelRatio * 1),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.08,
                alignment: AlignmentDirectional.center,
                width: double.infinity,
                // color: Colors.red,
                child: const Text(
                  'ยังไม่มีรายการ',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
              ),
            );
          },
        ),
        const Gap(10),
        Divider(
          color: Colors.grey.shade300,
          height: 1,
        ),
        const Gap(20),
      ],
    );
  }
}
