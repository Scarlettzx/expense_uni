// import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../../../../components/emailmultiselect_dropdown .dart';
import '../bloc/allowance_bloc.dart';

class CarbonCopyAllowance extends StatelessWidget {
  final Function(String) onCCEmailChanged;
  const CarbonCopyAllowance({
    super.key,
    required this.onCCEmailChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllowanceBloc, AllowanceState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Text(
              'CC ถึง',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade600),
            ),
            const Gap(10),
            EmailMultiSelectDropDown(
              onOptionSelected: (selectedValues) {
                String? concatenatedString;
                print(selectedValues);
                if (selectedValues.isNotEmpty && selectedValues != []) {
                  concatenatedString = selectedValues.join(';');
                } else {
                  concatenatedString = null;
                }
                onCCEmailChanged(concatenatedString ?? '');
              },
              options: state.empsallrole
                  .map((employee) => ValueItem(
                        label:
                            '${employee.firstnameTh!}  ${employee.lastnameTh} \n${employee.email}',
                        value: employee.firstnameTh! + employee.lastnameTh!,
                      ))
                  .toList(),
            ),
            const Gap(20),
          ],
        );
      },
    );
  }
}
