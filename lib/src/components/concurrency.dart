import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_expense/src/features/user/expense/presentation/bloc/expensegood_bloc.dart';

import 'models/concurrency_model,.dart';

class CurrencyDropdown extends StatefulWidget {
  // final List<ConcurrencyModel> currencies;
  // final ConcurrencyModel selectedCurrency;
  // final ValueChanged<ConcurrencyModel> onCurrencyChanged;
  final ExpenseGoodBloc expenseGoodBloc;
  const CurrencyDropdown({
    Key? key,
    // required this.currencies,
    // required this.selectedCurrency,
    // required this.onCurrencyChanged,
    required this.expenseGoodBloc,
  }) : super(key: key);

  @override
  State<CurrencyDropdown> createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  // late ConcurrencyModel? selectedCurrency;
  @override
  void initState() {
    super.initState();
    // selectedCurrency = widget.selectedCurrency;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseGoodBloc, ExpenseGoodState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border:
                  Border.all(color: Colors.grey.withOpacity(0.3), width: 2)),
          // color: Colors.red,
          height: 40,
          width: double.infinity,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<ConcurrencyModel>(
              menuMaxHeight: MediaQuery.of(context).devicePixelRatio * 150,
              padding: EdgeInsets.only(left: 20, right: 20),
              isExpanded: true,
              value: (state.selectedCurrency != null)
                  ? state.selectedCurrency
                  : state.currency!.first,
              onChanged: (ConcurrencyModel? newValue) {
                // Ensure that the selected value is not null before updating the state
                if (newValue != null) {
                  widget.expenseGoodBloc.add(SelectCurrenyEvent(
                    selectedCurrency: newValue,
                  ));
                  widget.expenseGoodBloc.add(CalcualteSumEvent());
                  //   setState(() {
                  //     selectedCurrency = newValue;
                  //     widget.onCurrencyChanged(newValue);
                  //   });
                }
              },
              items: state.currency!.map<DropdownMenuItem<ConcurrencyModel>>(
                  (ConcurrencyModel currency) {
                return DropdownMenuItem<ConcurrencyModel>(
                  value: currency,
                  child: Row(
                    children: [
                      Image.network(
                          'https://flagcdn.com/16x12/${currency.code!.toLowerCase()}.png'),
                      SizedBox(
                        width: 10,
                      ),
                      Text(currency.label!),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
