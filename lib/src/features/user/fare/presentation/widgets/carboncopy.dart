import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:uni_expense/src/features/user/fare/domain/entities/entities.dart';

import '../../../../../components/emailmultiselect_dropdown .dart';

class CarbonCopy extends StatelessWidget {
  final List<EmployeesAllRolesEntity> empallrole;
  final Function(String) onCCEmailChanged;
  const CarbonCopy({
    super.key,
    required this.empallrole,
    required this.onCCEmailChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          options: empallrole
              .map((employee) => ValueItem(
                    label:
                        '${employee.firstnameTh!}  ${employee.lastnameTh} \n${employee.email}',
                    value: employee.firstnameTh! + employee.lastnameTh!,
                  ))
              .toList(),
        ),
        const Gap(20),
        Divider(
          color: Colors.grey.shade300,
          height: 1,
        ),
        const Gap(20),
      ],
    );
  }
}
