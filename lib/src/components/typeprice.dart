import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../features/user/expense/presentation/bloc/expensegood_bloc.dart';
import 'models/typeprice_model.dart';

class CustomDropdownTypePrice extends StatefulWidget {
  // final List<TypePriceModel> items;
  // final TypePriceModel selectedValue;
  final ValueChanged<TypePriceModel?> onChanged;

  const CustomDropdownTypePrice({
    super.key,
    // required this.items,
    // required this.selectedValue,
    required this.onChanged,
  });

  @override
  State<CustomDropdownTypePrice> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdownTypePrice> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseGoodBloc, ExpenseGoodState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ประเภทราคา',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade600),
            ),
            const Gap(10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border:
                    Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
              ),
              height: 40,
              width: double.infinity,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<TypePriceModel>(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  isExpanded: true,
                  value: (state.selectedTypePrice != null)
                      ? state.selectedTypePrice
                      : state.typeprice!.first,
                  onChanged: widget.onChanged,
                  items: state.typeprice!.map<DropdownMenuItem<TypePriceModel>>(
                    (TypePriceModel item) {
                      return DropdownMenuItem<TypePriceModel>(
                        value: item,
                        child: Text(item.type!),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            const Gap(20),
            Divider(
              color: Colors.grey.shade300,
              height: 1,
            ),
          ],
        );
      },
    );
  }
}
