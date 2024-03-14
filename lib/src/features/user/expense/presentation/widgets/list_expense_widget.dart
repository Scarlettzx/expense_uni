import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';

import '../bloc/expensegood_bloc.dart';
// import '../pages/add_list_expense.dart';
import '../pages/add_listexpense.dart';
import 'customlisttile.dart';
import 'listheader.dart';

class ListExpenseWidget extends StatefulWidget {
  final ExpenseGoodBloc expensegoodBloc;
  final bool isdraft;
  const ListExpenseWidget({
    super.key,
    required this.expensegoodBloc,
    required this.isdraft,
  });

  @override
  State<ListExpenseWidget> createState() => _ListExpenseWidgetState();
}

class _ListExpenseWidgetState extends State<ListExpenseWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Gap(20),
        BlocBuilder<ExpenseGoodBloc, ExpenseGoodState>(
          builder: (context, state) {
            return ListHeaderRow(onPressed: () async {
              await Navigator.push(
                context,
                PageTransition(
                  duration: Durations.medium1,
                  type: PageTransitionType.rightToLeft,
                  child: AddListExpenseDemo(
                    isdraft: widget.isdraft,
                    expensegoodBloc: widget.expensegoodBloc,
                    typeprice: (state.selectedTypePrice != null)
                        ? state.selectedTypePrice!
                        : null,
                  ),
                ),
              );
            });
            // if (recieveData != null && recieveData!.isNotEmpty) {
            //   getData.addAll([recieveData!]);
            // }
            // calculateSum();
          },
        ),
        const Gap(10),
        BlocBuilder<ExpenseGoodBloc, ExpenseGoodState>(
            builder: (context, state) {
          final listexpense = state.listExpense;
          if (state.listExpense.isNotEmpty) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: listexpense.length,
              reverse: true,
              itemBuilder: (context, index) {
                return CustomListTile(
                  expensegoodBloc: widget.expensegoodBloc,
                  typeprice: state.selectedTypePrice,
                  data: listexpense[index],
                  index: index,
                  selectcurreny: (state.selectedCurrency != null)
                      ? state.selectedCurrency
                      : null,
                );
              },
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
        }),
        const Gap(5),
        Divider(
          color: Colors.grey.shade300,
          height: 1,
        ),
        const Gap(20),
      ],
    );
  }
}
