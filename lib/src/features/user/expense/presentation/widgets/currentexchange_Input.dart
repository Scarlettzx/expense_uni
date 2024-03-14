import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../components/custominputdecoration.dart';
import '../bloc/expensegood_bloc.dart';

class CurrencyExchangeRateInput extends StatelessWidget {
  final Function(String) onCurrencyRateChanged;

  const CurrencyExchangeRateInput({
    Key? key,
    required this.onCurrencyRateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseGoodBloc, ExpenseGoodState>(
      builder: (context, state) {
        if (state.status == FetchStatus.list ||
            state.status == FetchStatus.loadcurrency) {
          // print("state.currencyRate exchange inpuit");
          // print(state.currencyRate);
          return Visibility(
            visible: (state.selectedCurrency!.code != 'TH'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'อัตราการแลกเปลี่ยน ( บาท ต่อ 1 ${state.selectedCurrency?.unit})',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Gap(10),
                TextFormField(
                  initialValue: state.currencyRate.toString(),
                  onChanged: (val) => onCurrencyRateChanged(val),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim() == '' ||
                        value.trim() == '0.00') {
                      return 'Please enter a value';
                    }
                    return null; // Return null if the input is valid
                  },
                  decoration: CustomInputDecoration.getInputDecoration(),
                ),
                const Gap(20),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
