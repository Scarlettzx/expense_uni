import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:searchfield/searchfield.dart';
import 'package:uni_expense/src/features/user/allowance/presentation/bloc/allowance_bloc.dart';

import '../../../../../components/approverfield.dart';
import '../../../allowance/presentation/widgets/required_text.dart';

class ApproverFieldAllowance extends StatelessWidget {
  final TextEditingController approver;
  final Function(int) onApproverSuccess;
  const ApproverFieldAllowance({
    super.key,
    required this.approver,
    required this.onApproverSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllowanceBloc, AllowanceState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RequiredText(
              labelText: 'ผู้อนุมัติ',
              asteriskText: '*',
            ),
            const Gap(10),
            CustomSearchField(
              controller: approver,
              onSuggestionTap: (selectedItem) {
                if (selectedItem is SearchFieldListItem<String>) {
                  approver.text = selectedItem.item!;
                  FocusScope.of(context).unfocus();
                }
                print(approver.text);
              },
              suggestions: state.empsallrole
                  .map((e) => SearchFieldListItem(
                        "${e.firstnameTh} ${e.lastnameTh}",
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${e.firstnameTh} ${e.lastnameTh}"),
                        ),
                      ))
                  .toList(),
              validator: (String? value) {
                if (value != null && value.isNotEmpty) {
                  String enteredText = value.trim();
                  print("enteredText: '$enteredText'");

                  List<String> suggestionTexts = state.empsallrole
                      .map((e) => "${e.firstnameTh} ${e.lastnameTh}".trim())
                      .toList();
                  print("Suggestion Texts: $suggestionTexts");

                  List<Object> suggestionIds = state.empsallrole
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
                      onApproverSuccess((suggestionIds[index]) as int);
                      return null;
                    }
                  }
                }
                return 'Please Enter a valid State';
              },
            ),
            const Gap(30),
            Divider(
              color: Colors.grey.shade300,
              height: 1,
            ),
            const Gap(20),
          ],
        );
      },
    );
  }
}
