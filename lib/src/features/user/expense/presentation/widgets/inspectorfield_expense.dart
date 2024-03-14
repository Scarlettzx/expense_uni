import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:searchfield/searchfield.dart';
// import 'package:uni_expense/src/features/user/expense/domain/entities/entities.dart';

import '../../../../../components/approverfield.dart';
import '../bloc/expensegood_bloc.dart';
// import '../../../../../components/searchfield.dart';

class InspectorFieldExpense extends StatelessWidget {
  final TextEditingController reviewer;
  // final List<EmployeeRoleAdminEntity> empsroleadmin;
  final Function(int) onReviewerSuccess;
  const InspectorFieldExpense({
    super.key,
    required this.reviewer,
    // required this.empsroleadmin,
    required this.onReviewerSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseGoodBloc, ExpenseGoodState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ผู้ตรวจสอบ',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade600),
            ),
            const Gap(10),
            CustomSearchField(
              validator: (String? value) {
                if (value != null && value.isNotEmpty) {
                  String enteredText = value.trim();
                  print("enteredText: '$enteredText'");

                  List<String> suggestionTexts = state.empsroleadmin
                      .map((e) => "${e.firstnameTh} ${e.lastnameTh}".trim())
                      .toList();
                  print("Suggestion Texts: $suggestionTexts");

                  List<Object> suggestionIds = state.empsroleadmin
                      .map((e) => e.idEmployees ?? "")
                      .toList();
                  print("Suggestion Ids: $suggestionIds");

                  if (suggestionTexts
                      .map((e) => e.replaceAll(RegExp(r'\s+'), ''))
                      .contains(enteredText.replaceAll(RegExp(r'\s+'), ''))) {
                    int index = suggestionTexts
                        .map((e) => e.replaceAll(RegExp(r'\s+'), ''))
                        .toList()
                        .indexOf(enteredText.replaceAll(RegExp(r'\s+'), ''));

                    if (value == enteredText) {
                      onReviewerSuccess((suggestionIds[index]) as int);
                      return null;
                    }
                  }
                }
                return 'Please Enter a valid State';
              },
              onSuggestionTap: (selectedItem) {
                if (selectedItem is SearchFieldListItem<String>) {
                  reviewer.text = selectedItem.item!;
                  FocusScope.of(context).unfocus();
                }
                print(reviewer.text);
              },
              controller: reviewer,
              suggestions: state.empsroleadmin
                  .map((e) =>
                      SearchFieldListItem("${e.firstnameTh}  ${e.lastnameTh}",
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${e.firstnameTh}  ${e.lastnameTh}"),
                          )))
                  .toList(),
            ),
            const Gap(20),
          ],
        );
      },
    );
  }
}
