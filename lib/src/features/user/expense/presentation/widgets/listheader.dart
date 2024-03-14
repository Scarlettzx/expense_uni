// Separate stateless widget for the Row with "รายการ" text and "Add" button
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/expensegood_bloc.dart';

class ListHeaderRow extends StatelessWidget {
  final Function() onPressed;

  const ListHeaderRow({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseGoodBloc, ExpenseGoodState>(
      builder: (context, state) {
        print(state.selectedCurrency);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: 'รายการ ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (state.selectedCurrency != null &&
                      state.selectedCurrency?.code != 'TH')
                    TextSpan(
                      text: '(หน่วย ${state.selectedCurrency?.unit!})',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(30.0),
              onTap: onPressed,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffff99ca),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).devicePixelRatio * 7,
                  vertical: MediaQuery.of(context).devicePixelRatio * 2.5,
                ),
                child: Text(
                  '+ เพิ่มรายการ',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
