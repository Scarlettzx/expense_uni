import 'package:flutter/material.dart';

import 'models/typeprice_model.dart';

class CustomDropdownTypePrice extends StatefulWidget {
  final List<TypePriceModel> items;
  final TypePriceModel selectedValue;
  final ValueChanged<TypePriceModel?> onChanged;

  const CustomDropdownTypePrice({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  State<CustomDropdownTypePrice> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdownTypePrice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
      ),
      height: 40,
      width: double.infinity,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TypePriceModel>(
          padding: EdgeInsets.only(left: 20, right: 20),
          isExpanded: true,
          value: widget.selectedValue,
          onChanged: widget.onChanged,
          items: widget.items.map<DropdownMenuItem<TypePriceModel>>(
            (TypePriceModel item) {
              return DropdownMenuItem<TypePriceModel>(
                value: item,
                child: Text(item.type!),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
