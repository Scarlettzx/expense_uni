import 'package:flutter/material.dart';

import 'models/concurrency_model,.dart';

class CurrencyDropdown extends StatefulWidget {
  final List<ConcurrencyModel> currencies;
  final ConcurrencyModel selectedCurrency;
  final ValueChanged<ConcurrencyModel> onCurrencyChanged;
  const CurrencyDropdown({
    Key? key,
    required this.currencies,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
  }) : super(key: key);

  @override
  State<CurrencyDropdown> createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  late ConcurrencyModel? selectedCurrency;
  @override
  void initState() {
    super.initState();
    selectedCurrency = widget.selectedCurrency;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 2)),
      // color: Colors.red,
      height: 40,
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ConcurrencyModel>(
          padding: EdgeInsets.only(left: 20, right: 20),
          isExpanded: true,
          value: selectedCurrency,
          onChanged: (ConcurrencyModel? newValue) {
            // Ensure that the selected value is not null before updating the state
            if (newValue != null) {
              setState(() {
                selectedCurrency = newValue;
                widget.onCurrencyChanged(newValue);
              });
            }
          },
          items: widget.currencies.map<DropdownMenuItem<ConcurrencyModel>>(
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
  }
}
