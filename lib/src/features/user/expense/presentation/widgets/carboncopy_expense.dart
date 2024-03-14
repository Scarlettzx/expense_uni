// import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
// import 'package:uni_expense/src/features/user/expense/domain/entities/entities.dart';
// import 'package:uni_expense/src/features/user/expense/presentation/bloc/expensegood_bloc.dart';

import '../../../../../components/emailmultiselect_dropdown .dart';
import '../bloc/expensegood_bloc.dart';

class CarbonCopyExpense extends StatelessWidget {
  final Function(String) onCCEmailChanged;
  // final List<EmployeesAllRolesEntity> empallrole;
  const CarbonCopyExpense({
    super.key,
    // required this.empallrole,
    required this.onCCEmailChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseGoodBloc, ExpenseGoodState>(
      builder: (context, state) {
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
