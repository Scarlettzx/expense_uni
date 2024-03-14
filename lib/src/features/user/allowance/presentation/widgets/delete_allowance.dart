// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../data/models/delete_expenseallowance_model.dart';
import '../../domain/entities/entities.dart';
import '../bloc/allowance_bloc.dart';
import '../pages/allowance_general_infor.dart';

class DeleteDraftAllowance extends StatelessWidget {
  final AllowanceBloc? allowanceBloc;
  final int? idEmp;
  final int? idExpense;
  final int? idExpenseAllowance;
  final List<ListExpensegetallowancebyidEntity>? listExpense;
  final bool? isManageItemtoPageEdit;
  final FileUrlGetAllowanceByIdEntity? fileUrl;

  const DeleteDraftAllowance({
    super.key,
    required this.allowanceBloc,
    required this.idEmp,
    required this.idExpense,
    required this.idExpenseAllowance,
    required this.listExpense,
    required this.isManageItemtoPageEdit,
    required this.fileUrl,
  });
  @override
  Widget build(BuildContext context) {
    List<int>? idExpenseAllowanceItems = [];
    bool isAttachFile = false;
    String? filepath;
    if (idEmp != null &&
        idExpense != null &&
        idExpenseAllowance != null &&
        listExpense != null) {
      idExpenseAllowanceItems = listExpense!
          .map((expenseItem) {
            return expenseItem.idExpenseAllowanceItem;
          })
          .cast<int>()
          .toList();
    } else {
      print(
          "One or more of idEmp, idExpense, idExpenseAllowance, listExpense is null.");
    }

    // idExpenseAllowanceItems = listExpense!.map((expenseItem) {
    //   return expenseItem.idExpenseAllowanceItem;
    // }).toList();
    return Container(
      constraints: const BoxConstraints(maxWidth: 200.0),
      child: OutlinedButton.icon(
        onPressed: () {
          if (idEmp != null &&
              idExpense != null &&
              idExpenseAllowance != null &&
              listExpense != null) {
            if (fileUrl != null) {
              isAttachFile = true;
              filepath = fileUrl!.path;
            }
            allowanceBloc!.add(DeleteExpenseAllowanceEvent(
              idEmp: idEmp!,
              deleteallowancedata: DeleteExpenseAllowanceModel(
                idExpense: idExpense,
                idExpenseAllowance: idExpenseAllowance,
                listExpense: idExpenseAllowanceItems,
                filePath: filepath,
                isAttachFile: isAttachFile,
              ),
            ));

            Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                duration: Durations.medium1,
                type: PageTransitionType.rightToLeft,
                child: const AllowanceGeneralInformation(),
              ),
              (route) => route.isFirst,
            );
            print(idExpenseAllowanceItems);
            print(idEmp);
            print(idExpense);
            print(idExpenseAllowance);
            print(filepath);
            print(isAttachFile);
          }
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          side: const BorderSide(
            width: 3.0,
            color: Colors.red,
          ),
        ),
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
        ),
        label: const Text(
          'ลบแบบร่าง',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
