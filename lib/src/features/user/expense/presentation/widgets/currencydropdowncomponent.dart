import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../components/concurrency.dart';
import '../../../../../components/models/concurrency_model,.dart';
import '../bloc/expensegood_bloc.dart';

class CurrencyDropdownComponent extends StatelessWidget {
  final ExpenseGoodBloc expenseGoodBloc;
  // final List<ConcurrencyModel> currencies;
  // final ConcurrencyModel selectedCurrency;
  // final Function(dynamic)
  //     onCurrencyChanged; // Can be any type based on your currency object

  const CurrencyDropdownComponent({
    Key? key,
    // required this.currencies,
    // required this.selectedCurrency,
    // required this.onCurrencyChanged,
    required this.expenseGoodBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseGoodBloc, ExpenseGoodState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'สกุลเงิน',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey.shade600,
              ),
            ),
            const Gap(10), // Fixed height for spacing
            CurrencyDropdown(
              expenseGoodBloc: expenseGoodBloc,
              // currencies: state.currency!,
              // selectedCurrency: state.currency!.first,
              // onCurrencyChanged: onCurrencyChanged,
            ),
            const Gap(20), // Fixed height for spacing
          ],
        );
      },
    );
  }
}
