// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../data/models/delete_expenseallowance_model.dart';
import '../../domain/entities/entities.dart';
import '../bloc/allowance_bloc.dart';

class DeleteDraft extends StatelessWidget {
  final AllowanceBloc allowanceBloc;
  final int? idEmp;
  final int? idExpense;
  final int? idExpenseAllowance;
  final List<ListExpensegetallowancebyidEntity>? listExpense;
  final FileUrl? fileUrl;
  final VoidCallback onDeleted;

  DeleteDraft({
    super.key,
    required this.allowanceBloc,
    required this.idEmp,
    required this.idExpense,
    required this.idExpenseAllowance,
    required this.listExpense,
    required this.fileUrl,
    required this.onDeleted,
  });
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<int>? idExpenseAllowanceItems = [];
  bool isAttachFile = false;
  var filepath = null;
  @override
  Widget build(BuildContext context) {
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
      constraints: BoxConstraints(maxWidth: 200.0),
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
            // AwesomeDialog(
            //   context: scaffoldKey.currentState!.context,
            //   animType: AnimType.scale,
            //   dialogType: DialogType.info,
            //   body: Center(
            //     child: Text(
            //       'If the body is specified, then title and description will be ignored, this allows to 											further customize the dialogue.',
            //       style: TextStyle(fontStyle: FontStyle.italic),
            //     ),
            //   ),
            //   title: 'This is Ignored',
            //   desc: 'This is also Ignored',
            //   btnOkOnPress: () {
            //     if (Navigator.canPop(scaffoldKey.currentState!.context)) {
            //       Navigator.pop(scaffoldKey.currentState!.context);
            //     }
            //   },
            // )..show();
            allowanceBloc.add(DeleteExpenseAllowanceEvent(
              idEmp: idEmp!,
              deleteallowancedata: DeleteExpenseAllowanceModel(
                idExpense: idExpense,
                idExpenseAllowance: idExpenseAllowance,
                listExpense: idExpenseAllowanceItems,
                filePath: filepath,
                isAttachFile: isAttachFile,
              ),
            ));
            onDeleted();
            print(idExpenseAllowanceItems);
            print(idEmp);
            print(idExpense);
            print(idExpenseAllowance);
            print(filepath);
            print(isAttachFile);
          }
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          side: BorderSide(
            width: 3.0,
            color: Colors.red,
          ),
        ),
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        label: Text(
          'ลบแบบร่าง',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
